from ..func import connect as conn
from .. import config as conf 
    
from twilio.rest import Client

# Your Account Sid and Auth Token from twilio.com/console
# DANGER! This is insecure. See http://twil.io/secure

def send_msg(content, reciver, ACCOUNT_SID, AUTH_TOKEN, SENDER):
    try:
        client = Client(ACCOUNT_SID, AUTH_TOKEN)
        message = client.messages \
                        .create(
                            body = content,
                            from_= SENDER,
                            to = reciver
                        )
        return message.sid
    except Exception as e:
        print('Twilio Error:', str(e))
        return None
        