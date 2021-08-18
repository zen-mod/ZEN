#!/usr/bin/env python3

from pathlib import Path
import json
import urllib.request

tools_path = Path(__file__).parent

authors = set([
    'ampersand38',
    'CreepPork',
    'Kexanone',
    'mharis001',
    'neilzar'
])

# Get contributors from GitHub
result = urllib.request.urlopen('http://api.github.com/repos/zen-mod/ZEN/contributors')
body = result.read()
contributors = set()
for entry in json.loads(body.decode("utf-8")):
    contributors.add(entry['login'])

# Get other contributors
with open(tools_path / '../AUTHORS.txt', 'r') as stream:
    for line in stream:
        if line.startswith('# CONTRIBUTORS'):
            break
    for line in stream:
        contributors.add(line.strip())

contributors -= authors

print('\n'.join(sorted(contributors, key=lambda name: name.lower())))
