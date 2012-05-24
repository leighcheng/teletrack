

#this is a test change
class AdminController < ApplicationController 
  before_filter :authorize    
  layout 'desktop'  
  
  def index
  end
  
  def backup_data
    #@backup_dir_file = 'S:\shares\is\Telecom\TeletrackBackup\Data\teletrack_data_dump_' + Time.now.strftime("%Y%m%d") + '.sql'
    @backup_dir_file = 'C:\backup\data\teletrack_data_dump_' + Time.now.strftime("%Y%m%d") + '.sql'   
    if system('mysqldump -h localhost -u root teletrack_development > ' + @backup_dir_file)
      flash[:notice] = "Successfully backed up database as " + @backup_dir_file  
    else
      flash[:notice] = "Failed to backup database to " + @backup_dir_file      
    end

    redirect_to :action => 'index'    
  end
  
  def backup_app
    #@backup_dir = 'S:\shares\is\Telecom\TeletrackBackup\Live\teletrack' + Time.now.strftime("%Y%m%d")
	@backup_dir = 'c:\backup\sites\teletrack' + Time.now.strftime("%Y%m%d")
    begin
      FileUtils.cp_r(Rails.root, @backup_dir, :remove_destination => true)   
      flash[:notice] = "Successfully backed up application Teletrack to " + @backup_dir + ' directory.'     
    rescue Exception => e
      flash[:notice] = "Failed to back up application Teletrack to " + @backup_dir + ' directory. ' + e.message        
    end
    
    redirect_to :action => 'index'      
  end
  
end
