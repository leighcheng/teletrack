class StatusesController < ApplicationController
  # GET /statuses
  # GET /statuses.xml
  
  before_filter :authorize  
  
  layout "desktop"
    
  def index
    @statuses = Status.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @statuses }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        flash[:notice] = 'Status was successfully created.'
        format.html { render :action => "edit" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.xml
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        flash[:notice] = 'Status was successfully updated.'
      else
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
      format.html { render :action => "edit" }
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    
    begin
      @status.destroy
    rescue Exception => e
#      flash[:notice] = e.message
       flash[:notice] = msg_can_not_delete
    end
    
    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end    
  end
end
