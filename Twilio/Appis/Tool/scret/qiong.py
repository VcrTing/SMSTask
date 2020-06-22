from Twilio.settings import QIONG

def _love(rec):
    rec = list(rec)
    l = len(rec) // 2

    return ''.join(rec[0: l]), ''.join(rec[l : -1])

def _hate(rec):
    el = (len(rec) - len(QIONG)) // 2
    return rec[0: el] + rec[el: -1][1: len(rec)]

def love(res):
    return QIONG.join(_love(res)) + "'" 

def hate(res):
    return _hate(res) + "'"