from twilio.rest import Client
import time


# Your Account Sid and Auth Token from twilio.com/console
# DANGER! This is insecure. See http://twil.io/secure
account_sid = '[Twilio sid]'
auth_token = '[Twilio Auth Token]'
client = Client(account_sid, auth_token)

def send_message(msg, to_):
    client.messages \
                    .create(
                        body=msg,
                        from_='+14178150100',
                        to=to_
                    )

def crime_in_location(to_, crimes, stop=10000):
    for crime in crimes:
        if(stop == 0):
            break
        send_message('A {0} crime was reported near you! Be careful!'.format(crime['message']), to_)
        stop -= 1