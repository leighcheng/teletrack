class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  
  def msg_can_not_delete
    @msg = "Message: Can not delete a parent record."  
  end
  
  def authorize
     unless current_user
        flash[:notice] = "Please log in"
        redirect_to log_in_path
     end
  end
  
  def debuger(file, line)
    flash[:notice] = "Debug at " + ' in ' + file + ' at line: ' + line.to_s
  end
  
  private
  
  def current_user
    @current_user ||= Staff.find(session[:staff_id]) if session[:staff_id]
  end
  
end
