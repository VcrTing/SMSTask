import requests
import json

MAILGUN_API = 'https://api.mailgun.net/v3/'

def send_message(domain, APIKEY, data):

	url = MAILGUN_API + domain + '/messages'
	res = requests.post( url, auth = ('api', APIKEY), data = data )

	if str(res.status_code).startswith('2'):
		return json.loads(res.text)
	else:
		return json.loads(res.text)

def _get_stats(domain, APIKEY, event, timed):

	url = MAILGUN_API + domain + '/stats/total'
	res = requests.get( url, auth = ('api', APIKEY), params = {
		'event': event,
		'duration': timed
	} )
	if res.text:
		return json.loads(res.text)
	return None

def get_stats_running(domain, APIKEY):
	return _get_stats(domain, APIKEY, ['delivered', 'failed'], '1h')

def get_stats_block(domain, APIKEY):
	return _get_stats(doamin, APIKEY, ['failed'], '6m')
