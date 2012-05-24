class PrioritiesController < ApplicationController
  # GET /priorities
  # GET /priorities.xml
  
  before_filter :authorize  
  
  layout "desktop"
  
  def index
    @priorities = Priority.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @priorities }
    end
  end

  # GET /priorities/new
  # GET /priorities/new.xml
  def new
    @priority = Priority.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @priority }
    end
  end

  # GET /priorities/1/edit
  def edit
    @priority = Priority.find(params[:id])
  end

  # POST /priorities
  # POST /priorities.xml
  def create
    @priority = Priority.new(params[:priority])

    respond_to do |format|
      if @priority.save
        flash[:notice] = 'Priority was successfully created.'
        format.html { render :action => "edit" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /priorities/1
  # PUT /priorities/1.xml
  def update
    @priority = Priority.find(params[:id])

    respond_to do |format|
      if @priority.update_attributes(params[:priority])
        flash[:notice] = 'Priority was successfully updated.'
      else
        format.xml  { render :xml => @priority.errors, :status => :unprocessable_entity }
      end
      format.html { render :action => "edit" }      
    end
  end

  # DELETE /priorities/1
  # DELETE /priorities/1.xml
  def destroy
    @priority = Priority.find(params[:id])

    begin
      @priority.destroy
    rescue Exception => e
#      flash[:notice] = e.message
       flash[:notice] = msg_can_not_delete
    end  

    respond_to do |format|
      format.html { redirect_to(priorities_url) }
      format.xml  { head :ok }
    end
  end
end
