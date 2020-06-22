import requests
import json

def send_message(domain, APIKEY, data):

	url = 'https://api.mailgun.net/v3/' + domain + '/messages'
	res = requests.post( url, auth = ('api', APIKEY), data = data )

	if str(res.status_code).startswith('2'):
		return json.loads(res.text)
	else:
		return json.loads(res.text)