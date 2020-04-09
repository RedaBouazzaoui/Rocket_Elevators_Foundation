require 'twilio-ruby'

account_sid = ENV["ACCOUNT_SID"]
auth_token = auth_token = ENV["TWILIO_AUTH_TOKEN"]
client = Twilio::REST::Client.new(account_sid, auth_token)

from = ENV["MY_PHONE_NUMBER"] # Your Twilio number
to = '+15149138302' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "Hello World!"
)