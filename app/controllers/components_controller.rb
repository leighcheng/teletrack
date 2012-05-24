class ComponentsController < ApplicationController
  # GET /components
  # GET /components.xml
  
  before_filter :authorize  
  
  layout "desktop"
  
  def index
    @components = Component.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @components }
    end
  end

  # GET /components/new
  # GET /components/new.xml
  def new
    @component = Component.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @component }
    end
  end

  # GET /components/1/edit
  def edit
    @component = Component.find(params[:id])
  end

  # POST /components
  # POST /components.xml
  def create
    @component = Component.new(params[:component])

    respond_to do |format|
      if @component.save
        flash[:notice] = 'Component was successfully created.'
        format.html { render :action => "edit" }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @component.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /components/1
  # PUT /components/1.xml
  def update
    @component = Component.find(params[:id])

    respond_to do |format|
      if @component.update_attributes(params[:component])
        flash[:notice] = 'Component was successfully updated.'
      else
        format.xml  { render :xml => @component.errors, :status => :unprocessable_entity }
      end
      format.html { render :action => "edit" }
    end
  end

  # DELETE /components/1
  # DELETE /components/1.xml
  def destroy
    @component = Component.find(params[:id])
    
    begin
      @component.destroy
    rescue Exception => e
#      flash[:notice] = e.message
       flash[:notice] = msg_can_not_delete
    end    
    
    respond_to do |format|
      format.html { redirect_to(components_url) }
      format.xml  { head :ok }
    end
  end
end
