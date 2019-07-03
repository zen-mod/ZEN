#!/usr/bin/env python3
import urllib.request
import json
import platform
import os
import os.path as path
import zipfile
import tarfile

print('Fetching API data')

with urllib.request.urlopen("https://api.github.com/repos/synixebrett/HEMTT/releases/latest") as url:
    releaseJson = json.loads(url.read().decode())['assets']

    scriptDir = path.dirname(path.realpath(__file__))
    oneDirUp = path.abspath(path.join(scriptDir, '..'))

    hemttFile = path.join(oneDirUp, 'hemtt.exe')
    extension = '.zip'

    if (platform.system() == 'Windows'):
        releaseJson = releaseJson[3]
    elif (platform.system() == 'Linux'):
        releaseJson = releaseJson[4]
        hemttFile = path.join(oneDirUp, 'hemtt')
        extension = '.tar.gz'
    else:
        raise OSError('Your OS is not supported by this utility. Download HEMTT manually.')

    releaseUrl = releaseJson['browser_download_url']

    zipPath = path.join(oneDirUp, 'hemtt{}'.format(extension))

    if (path.isfile(hemttFile)):
        print('Removing existing HEMTT version')
        os.remove(hemttFile)

    print('Downloading from {}'.format(releaseUrl))
    urllib.request.urlretrieve(releaseUrl, zipPath)

    print('Extracting archive')

    extractPath = path.join(oneDirUp, 'tmp')
    if (extension == '.zip'):
        hemtt = zipfile.ZipFile(zipPath, 'r')
        hemtt.extractall(extractPath)
        hemtt.close()

        print('Moving files')
        os.remove(path.join(extractPath, 'setup.exe'))
        os.rename(path.join(extractPath, 'hemtt.exe'), hemttFile)
        os.removedirs(extractPath)
    else:
        hemtt = tarfile.open(zipPath, 'r')
        hemtt.extractall(extractPath)
        hemtt.close()

        print('Moving files')
        os.rename(path.join(extractPath, 'hemtt'), hemttFile)
        os.removedirs(extractPath)

    print('Removing temp archive file')
    os.remove(zipPath)
