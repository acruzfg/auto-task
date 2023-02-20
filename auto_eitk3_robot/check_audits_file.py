import sys
import os
import csv

AUDITS_FILE        = str(sys.argv[1]) #uses the file name entered by robotframework
CLEANUPTIME        = str(sys.argv[2]) #uses the datetime entered by robotframework
CSVFILE            = open(AUDITS_FILE, 'r')
READER             = csv.reader(CSVFILE, delimiter=',')
COUNTER            = 0
for row in READER:
    if row[0] == CLEANUPTIME and COUNTER != 0:
        ENTRY = {'Date': row[0], 'Node':row[1], 'App':row[2], 'User Name':row[3],'Display Name':row[4],'Console Name':row[5],'Message':row[6]}
        COUNTER=+1
        if ENTRY['Message'] == '':
            print("OK")

CSVFILE.close()
os.remove(AUDITS_FILE)