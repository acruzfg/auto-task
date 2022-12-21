import os
import sys
from py_jama_rest_client.client import JamaClient

testname = str(sys.argv[1]) #uses the name entered by robotframework
oauth_client = JamaClient(host_domain='https://osi.jamacloud.com', credentials=('r6ft8sksuttv8sp', 'j8pvfl0t7b64xv55rohy8dksy'), oauth=True)
testcyle=9373533 #this needs to change every testcycle
#testname='Automated - Chrome - Create a Task'   #searchs for the id based on the testname in the testcycle, used this as first example because I didn't create a DCT automated test case in JAMA jeje

testruns = oauth_client.get_testruns(testcyle)


for run in testruns:
    if run['fields']['name'] == testname:
        id = run['id']
        print(id)
        break
    else:
        pass



    