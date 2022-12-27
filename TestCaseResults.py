import sys
from py_jama_rest_client.client import JamaClient

testname = str(sys.argv[0]) #uses the name entered by robotframework
testcyle = str(sys.argv[1])
oauth_client = JamaClient(host_domain='https://osi.jamacloud.com', credentials=('r6ft8sksuttv8sp', 'j8pvfl0t7b64xv55rohy8dksy'), oauth=True)
#testcyle= 9373533#this needs to change every testcycle
testruns = oauth_client.get_testruns(testcyle)

for run in testruns:
    if run['fields']['name'] == testname:
        id = run['id']
        print(id)
        break
    else:
        pass