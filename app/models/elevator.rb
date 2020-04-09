require 'send_sms/sms'
require 'slack-notifier'
class Elevator < ApplicationRecord
    belongs_to :column

    
    after_update :send_sms, if: :intervention?
   
    
    # before_update :slack_notifier

    # def slack_notifier
    #     if self.status_changed?
    #       require 'date'
    #       current_time = DateTime.now.strftime("%d-%m-%Y %H:%M")
    #       notifier = Slack::Notifier.new "https://hooks.slack.com/services/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" do
    #         defaults channel: "#elevator_operations"
    #       end
    #       notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{self.status_was} to #{self.status} at #{current_time}."
    # end
         
    
    
        
    # end
    

    def send_sms()
        tech = self.column.battery.building.tech_full_name
        id = self.id
        sn = self.serial_number
        status = self.status
        sms = SendSms::Sms.new
        sms.send_sms(tech, id, sn, status)
    end

    def intervention?
        self.status == "Intervention"
    end

end      


