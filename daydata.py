#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import argparse, json, logging, csv, re, sys, codecs, re
from pathlib import Path
import pandas as pd

floatre = re.compile("^\d+\.\d+$")
intre = re.compile("^\d+$")

file="h.txt"
header=[]
for line in open(file):
    header.append(line.strip())
logging.info("%d lines in header", len(header))

def process_csv(file, header):
    out=[]
    stdin = file == "-"
    fd = sys.stdin if stdin else codecs.open(file, 'r', 'UTF-8')
    reader = csv.reader(fd)
    for nr, row in enumerate(reader):
        logging.debug("%d fields in line %d", len(row), nr)
        d = dict()
        out.append(d)
        for i, field in enumerate(row):
            if field != "NULL":
                if floatre.match(field):
                    d[header[i]] = float(field)
                elif intre.match(field):
                    d[header[i]] = int(field)
                else:
                    d[header[i]] = field
    if not stdin:
        fd.close()
    return out

includedcols = ["birthDate"]
indexedIC = []
for item in includedcols:
    indexedIC.append(header.index(item))
    
peoplelist = []        

for year in range(1900,2018):
    filepath = Path(str(year))
    
    with open(filepath) as file:
        data = csv.reader(file, delimiter = ",")
        for element in data:
            peoplelist.append([element[x] for x in indexedIC])

monthsDays = []

for element in peoplelist:
    for date in element:
        monthsDays.append(date[5:10])
        
with open('birthDays.csv', 'w') as file:
    csvwriter = csv.writer(file, delimiter=',')
    for item in monthsDays:
        file.write(item + '\n')


