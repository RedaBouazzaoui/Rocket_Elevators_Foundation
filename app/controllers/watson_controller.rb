class WatsonController < ApplicationController

    require "ibm_watson/authenticators"
    require "ibm_watson/text_to_speech_v1"
    include IBMWatson


    def welcome
        authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
        apikey: ENV["TEXT_TO_SPEECH_IAM_APIKEY"]
        )
        text_to_speech = TextToSpeechV1.new(
        authenticator: authenticator
        )
        text_to_speech.service_url = "https://api.us-south.text-to-speech.watson.cloud.ibm.com"
    
        first_name = current_employee.first_name
        last_name = current_employee.last_name
        total_elevators = Elevator.count
        total_buildings = Building.count
        total_customers = Customer.count
        out_of_service = Elevator.where.not(status:"active").count
        total_quotes = Quote.count
        total_leads = Lead.count
        total_batteries = Battery.count
        total_cities = Address.distinct.count(:city)
    
        File.open("app/assets/audios/hello_world.wav", "wb") do |audio_file|
            response = text_to_speech.synthesize(
              text: "Welcome,  #{first_name + last_name} you have #{total_elevators.to_s} elevators deployed in #{total_buildings.to_s} building belonging to #{total_customers.to_s} customers. Currently there are #{out_of_service.to_s} elevators out of service and #{total_quotes.to_s} quotes waiting to be processed. also, there are #{total_leads.to_s} leads in your contact requests and #{total_batteries.to_s} batteries across #{total_cities.to_s} cities" ,
              accept: "audio/wav",
              voice: "en-US_AllisonVoice"
            )
            audio_file.write(response.result)
            redirect_back(fallback_location:"/")
        end
    end
end
