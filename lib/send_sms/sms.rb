require 'twilio-ruby'

module SendSms
    class Sms
        def initialize
        end

        def send_sms(technician, id, sn, status)
            account_sid = ENV["TWILIO_ACCOUNT_SID"]
            auth_token =ENV["TWILIO_AUTH_TOKEN"]
            client = Twilio::REST::Client.new(account_sid, auth_token)

            from = ENV["TWILIO_PHONE_NUMBER"] # Your Twilio number

            to = '+15149912026' # Your mobile phone number


            client.messages.create(
            from: from,
            to: to,
            body: "The elevator #{id} with Serial Number #{sn} needs an #{status}. The technician assigned is: #{technician}."
            )
        end

        def intervention?()
            self.status == "Intervention"
        end
    end
end