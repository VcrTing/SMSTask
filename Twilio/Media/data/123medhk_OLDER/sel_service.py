import os, json

def _sel_service(item):
    name = item[1]
    time_rule = item[2]
    return {
        'name': name,
        'time_rule': time_rule
    }

def _sel(line, flag):
    line = str(line).strip('\n')
    line = eval(line[0: -1])

    return _sel_service(line)


service = []

file = open("sms_service.sql")
for line in file.readlines():
    service.append(_sel(line, 'service'))
file.close()


service_file = 'service.json'
with open(service_file, 'w') as f:
    f.write(json.dumps(service))