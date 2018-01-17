#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#import all necessary packages
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

#select the columns you want to include in the CSV file
includedcols = ["birthDate"]
indexedIC = []
for item in includedcols:
    indexedIC.append(header.index(item))
    
#generate for loop to include all the years, since they're in separate files
peoplelist = []        
for year in range(1900,2018):
    filepath = Path(str(year))
    
    with open(filepath) as file:
        data = csv.reader(file, delimiter = ",")
        for element in data:
            peoplelist.append([element[x] for x in indexedIC])

#write to a new list       
finalDates = []
for element in peoplelist:
    for date in element:
        #make sure there are no messed up values containing weird strings
        if not any(x in date for x in ['{', 'T', '}']): 
            finalDates.append(date.split('-'))

            #finalize list        
months = [x[1] for x in finalDates]

#write to CSV
with open('birthdates.csv', 'w') as file:
    for item in months:
        file.write(item + '\n')



