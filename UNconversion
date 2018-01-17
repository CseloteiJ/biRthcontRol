#!/usr/bin/env python3
# -*- coding: utf-8 -*-

#import all necessary packages
import argparse, json, logging, csv, re, sys, codecs, re
from pathlib import Path
import pandas as pd

#read data from the CSV file into a new list
livebirthdataset = []
    
with open("livebirthdata.csv") as file:
    data = csv.reader(file, delimiter = ",")
    file.readline()
    for row in data:
        if len(row) > 6: 
            if not any(x in row[3] for x in ['Total', ' ', 'Unknown']):
                if not any(x in row[7] for x in ['.']):
                    livebirthdataset.append(row)

#isolate the information on month and total births
livebirthmonth = [item[3] for item in livebirthdataset]
livebirthtotal = [item[7] for item in livebirthdataset]

livebirthData = [[i, j] for i, j in zip(livebirthmonth, livebirthtotal)]

#create a dictionary out of which the total births will emerge through a for loop
totalbirthsDict = {"January": 0, "February":0, "March":0, "April":0, "May":0, "June":0, "July":0, "August":0, "September":0, "October":0, "November":0, "December":0}
for item in livebirthData:
    totalbirthsDict[item[0]] += int(item[1])

#list the items in the dictionary
livebirthtotal = list(totalbirthsDict.items())
    

#export the data to a CSV file
with open("livebirths.csv", "w") as output:
    writer = csv.writer(output)
    writer.writerows(livebirthtotal)
