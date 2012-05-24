class SessionsController < ApplicationController
  
  layout 'login'
  
  def new
  end
  
  def create
    staff = Staff.authenticate(params[:name], params[:password])
    if staff
      session[:staff_id] = staff.id
      flash[:notice] = nil
      if not request.user_agent.include?("iPhone")
        redirect_to tickets_path
      else
        redirect_to mobile_path
      end
    else
      #flash.now.alert = "Invalid email or password"
      flash[:notice] = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:staff_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end