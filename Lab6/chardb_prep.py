import dbm.gnu
import os
import urllib.request
import zipfile

DERIVED_NAMES_URL = 'https://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedName.txt'
DERIVED_NAMES_FILENAME = 'DerivedName.txt'
UNIHAN_ZIP_URL = 'https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip'
UNIHAN_ZIP_FILENAME = 'Unihan.zip'

# Which of the Unihan fields will be the description of the character? Some choices...
UNIHAN_FIELD = 'kDefinition'
#UNIHAN_FIELD = 'kMandarin'
#UNIHAN_FIELD = 'kCantonese'
#UNIHAN_FIELD = 'kKorean'
#UNIHAN_FIELD = 'kJapaneseOn'

DATABASE_FILENAME = 'UnicodeData.gdbm'


def ensure_file(url, filename):
    if not os.path.isfile(filename):
        with urllib.request.urlopen(url) as req, open(filename, 'wb') as outfile:
            print(f'Downloading {filename}...')
            for d in req:
                outfile.write(d)


def main():
    ensure_file(DERIVED_NAMES_URL, DERIVED_NAMES_FILENAME)
    ensure_file(UNIHAN_ZIP_URL, UNIHAN_ZIP_FILENAME)

    with dbm.gnu.open(DATABASE_FILENAME, 'c') as gdb:
        print('Producing character database...')

        # most of the characters are described in DerivedName.txt
        with open(DERIVED_NAMES_FILENAME, 'rt', encoding='utf-8') as datafile:
            for line in datafile:
                line = line.strip()
                if line.startswith('#') or line == '' or '*' in line:
                    continue
                
                n_hex, descr = line.split(';', 1)
                n = int(n_hex.strip(), 16)
                key = f'{n:08X}'
                gdb[key] = descr.strip().encode('utf-8')

        # Chinese, Japanese, and Korean characters are in the Unihan data set
        with zipfile.ZipFile(UNIHAN_ZIP_FILENAME, 'r') as ucd_zip, \
                ucd_zip.open('Unihan_Readings.txt', 'r') as readings:
            for line in readings:
                line = line.strip()
                if line.startswith(b'#') or line == b'':
                    continue
                
                codept, field, value = line.decode('utf-8').split('\t', 2)
                if field != UNIHAN_FIELD:
                    continue
                
                assert codept.startswith('U+')
                n = int(codept[2:], 16)
                key = f'{n:08X}'
                gdb[key] = value.upper().encode('utf-8')


main()