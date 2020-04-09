class ContactsMailer < ApplicationMailer
    default :from => 'Rocket Elevators <ng.afandy@gmail.com>'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def contact_email(lead)
    @lead = lead
    mail( 
        :to => "tiboclan@gmail.com",
        :subject => 'Thank you for contacting Rocket Elevators' )
  end
end
