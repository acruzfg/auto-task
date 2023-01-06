import sys
from jama import jama_proxy
from sysmanlib import reporting


def ReportingToJama(Status, JamaPlan_ID, JamaTestCase_ID):
    if Status == 'PASS':
        reporting.report_pass_fail_to_jama(True, JamaPlan_ID, JamaTestCase_ID, '')
    else:
        reporting.report_pass_fail_to_jama(False, JamaPlan_ID, JamaTestCase_ID, '')

if __name__ == '__main__':
    ReportingToJama(Status, JamaPlan_ID, JamaTestCase_ID)




