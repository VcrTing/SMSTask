
_XSS = [
    '.cookie',
    'document.',
    '<script'
]

def xss(rec):
    rec = str(rec).replace(' ','')
    rec = rec.lower()

    for x in _XSS:
        if x in rec:
            return True
    return False

def sql(rec):
    pass