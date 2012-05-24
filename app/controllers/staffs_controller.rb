class StaffsController < ApplicationController
  
  before_filter :authorize  
  
  layout 'desktop'

  def new
    @staff = Staff.new
  end
  
  def create
    @staff = Staff.new(params[:staff])
    if @staff.save
      redirect_to staffs_path, :notice => "Signed up!"
    else
      render "new"
    end
  end
  

    def index

     @staffs = Staff.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @staffs }
      end
    end

    def edit
      @staff = Staff.find(params[:id])
    end

    def update
      @staff = Staff.find(params[:id])

      respond_to do |format|
        if @staff.update_attributes(params[:staff])
          flash[:notice] = 'Password was successfully changed.'
        else
          format.xml  { render :xml => @staff.errors, :status => :unprocessable_entity }
        end
        format.html { redirect_to staffs_path }
      end
    end

    def destroy
      @staff = Staff.find(params[:id])

      begin
        @staff.destroy
      rescue Exception => e
        flash[:notice] = msg_can_not_delete
      end  

      respond_to do |format|
        format.html { redirect_to staffs_path }
      end
    end
end
