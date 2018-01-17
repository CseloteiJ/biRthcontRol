#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#import packages
import argparse, json, logging, csv, re, sys, codecs, re
from pathlib import Path
import pandas as pd

#david's code
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

#choose included columns
includedcols = ["birthDate"]
indexedIC = []
for item in includedcols:
    indexedIC.append(header.index(item))
 
#iterate through year files and add to a list
peoplelist = []        
for year in range(1900,2018):
    filepath = Path(str(year))
    
    with open(filepath) as file:
        data = csv.reader(file, delimiter = ",")
        for element in data:
            peoplelist.append([element[x] for x in indexedIC])

#create a new list containing the relevant data (5:10)
monthsDays = []
for element in peoplelist:
    for date in element:
        if not any(x in date for x in ['{', 'T', '}']): 
            monthsDays.append(date[5:10])
        
#write data to a CSV file
with open('birthDays.csv', 'w') as file:
    csvwriter = csv.writer(file, delimiter=',')
    for item in monthsDays:
        file.write(item + '\n')



