import time
from Appis.Tool.send import mailgun_status


def thing():
    import os, sys, requests
    from Appis.Tool.func.slice import get_conf
    APP_KEY, DOMAIN, SENDER = get_conf('mailgun')

    key = ''# sys.argv[1]
    filename = 'message.eml'

    url = "https://api.mailgun.net/v3/domains/" + DOMAIN + "/messages/" + str(key)

    r = requests.get(url, auth = ('api', APP_KEY), headers = {"Accept": "message/rfc2822"})

    if r.status_code == 200:
        with open(filename, "w") as message:
            message.write(r.json()["body-mime"])
        os.system("thunderbird -file " + filename)

    else:
        print("Oops! Something went wrong: ", str(r.content))

def get_logs():
    import os, sys, requests
    from Appis.Tool.func.slice import get_conf
    APP_KEY, DOMAIN, SENDER = get_conf('mailgun')

    url = 'https://api.mailgun.net/v3/' + DOMAIN + '/events'
    res = requests.get(url, auth = ('api', APP_KEY), params = {
        # 'ascending': 'yes',
        'limit': 25,
        # 'pretty': 'yes',
        'recipients': 'eric@manfulls.com',
        'begin': 'Wed, 21 Oct 2020 09:00:00 -0000'
    })
    print(res.text)

# Email 
def _get_status_email():

    res = mailgun_status(0)
    
    if res:
        failed = res['stats'][0]['failed']
        delivered = res['stats'][0]['delivered']
        
        
# 运行任务状态检索
def _running_status():
    # _get_status_email()
    # print('------------------')
    pass