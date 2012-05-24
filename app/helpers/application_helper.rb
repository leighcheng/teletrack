# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def is_owner(s)
    session[:staff_id] == s
  end
  
  def is_admin
    "administrator|lei".include?(Staff.find(session[:staff_id]).name)
  end  
  
  def is_guest
    Staff.find(session[:staff_id]).name == 'guest'
  end  
    
end
