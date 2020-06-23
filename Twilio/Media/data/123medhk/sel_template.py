import os, json

def _sel_template(item):
    sms_id = item[1]
    sms_id_sub = item[9]
    content = item[3]
    content_sub = item[4]
    lang = item[10]
    service = item[8]
    category = item[7]
    return {
        'sms_id': sms_id,
        'sms_id_sub': sms_id_sub,
        'content': content,
        'lang': lang,
        'service': service,
        'category': category,
        'content_sub': content_sub
    }

def _sel(line, flag):
    line = str(line).strip('\n')
    line = line[0: -1]
    print('Line =', line)
    print('Line Tuple =', tuple(line))
    return _sel_template(line)



template = []

file = open("sms_template.sql")
for line in file.readlines():
    template.append(_sel(line, 'template'))
file.close()

print(template)

template_file = 'template.json'
with open(template_file, 'w') as i:
    i.write(json.dumps(service))

