class StaffMailer < ActionMailer::Base

  layout 'email'    
  	
  default :from => "phoneadmin@odscompanies.com"
  
  def ticket_email(staff, ticket)
    @staff = staff
    @url  = "http://localhost:3000/"
    @ts = ticket
    mail(:to => staff.email, :subject => "Teletrack Updates")
  end  
  
end
