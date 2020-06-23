import os, json

def _sel_service(item):
    name = itme[1]
    time_rule = item[2]
    return {
        'name': name,
        'time_rule': time_rule
    }

def _sel_template(item):
    sms_id = itme[1]
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
    line = line[0:-1]
    line = tuple(line)
    if flag == 'service':
        return _sel_service(line)
    elif flag == 'template':
        return _sel_template(line)


service = []
template = []

file = open("sms_service.sql")
for line in file.readlines():
    service.append(_sel(line, 'service'))
file.close()

file = open("sms_template.sql")
for line in file.readlines():
    template.append(_sel(line, 'template'))
file.close()


service_file = 'service.json'
with open(service_file, 'w') as f:
    f.write(json.dumps(service))

template_file = 'template.json'
with open(template_file, 'w') as i:
    i.write(json.dumps(service))

service_file.close()
template_file.close()