import random
from base64 import b64encode, b64decode 

_saltA = ['z', 'y', 'x', 'w', 'v', 'u', 't', 's', 'r', 'q', 'p', 'o', 'n', 'm', 'l', 'k', 'j', 'i', 'h', 'g', 'f', 'e', 'd', 'c', 'b', 'a']
_saltB = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
_salt = _saltB + _saltA + _saltB
_qiong = '|2'

def _zyq():
    return ''.join(random.sample(_salt, random.randint(6, 10)))

def _encode(rec):
    return str(b64encode(rec.encode('utf-8')))

def _decode(rec):
    return b64decode(rec).decode("utf-8")

def _ensalt(rec):
    lens = len(rec)
    kans = random.randint(3, 6)

    v = lens // kans
    res = []

    for i in range(0, kans):
        if i != (kans- 1):
            res.append(
                rec[(v* i) : v* (i+ 1)]
            )
        else:
            res.append(
                rec[(v* i) : ]
            )
    return str(_qiong).join(res)

def vcrting(res, conditional):
    from .qiong import love, hate
    if conditional:
        return love(res)
    else:
        return hate(res)

def ensalt(rec):
    res = _ensalt(rec) + _qiong + _zyq()
    return _encode(res)

def desalt(rec):
    rec = vcrting(rec, False)
    res = _decode(eval(rec))
    res = res.split(_qiong)
    return ''.join(res[0: -1])
