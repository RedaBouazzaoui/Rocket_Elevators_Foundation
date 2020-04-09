require("bundler")
Bundler.requiee()

account_sid = ENV["TWILIO_ACCOUNT_SID"]
auth_token = ENV["TWILIO_AUTH_TOKEN"]

@client = Twilio::REST::Client.new(account_sid, auth_token)

@client.messages.create(
    to: ENV["MY_PHONE_NUMBER"],
    from: "+12035948823", 
    body: "Robot invasion! Reply"
)