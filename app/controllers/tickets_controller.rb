class TicketsController < ApplicationController
  # GET /tickets
  # GET /tickets.xml
  
  before_filter :authorize 
  
  layout "desktop"
 
  def index  
  
    session['searchwhat'] = "#{params[:searchwhat]}"      
    
    case "#{params[:searchwhat]}"
      when 'Summary'
        @searchwhat = 'summary like ? ' 
        @searchstring = "%#{params[:search]}%"    
      when 'Ticket ID'
        @searchwhat = 'id = ? '
        @searchstring = "#{params[:search]}"        
      when 'Assigned To'
        @searchwhat = 'assigned_id = ? ' 
        @searchstring = Staff.find(:first, :conditions => {"name" => "#{params[:search]}" })               	    
      when 'Component'
        @searchwhat = 'component_id = ? '  
        @searchstring = Component.find(:first, :conditions => {"component_name" => "#{params[:search]}" })         
      when 'Status'
        @searchwhat = 'status_id = ? '  
        @searchstring = Status.find(:first, :conditions => {"status_name" => "#{params[:search]}" })         
      when 'Priority'
        @searchwhat = 'priority_id = ? ' 
        @searchstring = Priority.find(:first, :conditions => {"priority_name" => "#{params[:search]}" })         
      when 'Created By'
        @searchwhat = 'created_id = ? '   
        @searchstring = Staff.find(:first, :conditions => {"name" => "#{params[:search]}" })    
      else
        @searchwhat = 'type_id = ? '  
        @searchstring = Type.find(:first, :conditions => {"type_name" => "Project" })     
    end

    @tickets = Ticket.where(@searchwhat, @searchstring).order("id desc").page(params[:page]).per(7)                         
    @ticket_count = Ticket.where(@searchwhat, @searchstring).size                           
                                                   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tickets }      
    end
  end
  
  # GET /tickets/1
  # GET /tickets/1.xml
  def show
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  # GET /tickets/new
  # GET /tickets/new.xml
  def new
    @ticket = Ticket.new
    @page_title = "New Ticket"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end

  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
    @ticket_id = @ticket.id
    @notes = Note.find(:all, :conditions =>{:ticket_id => params[:id]})
  end

  # POST /tickets
  # POST /tickets.xml
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.created_id = session[:staff_id]

    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
    else
      flash[:notice] = 'Failed to created new ticket.'      
    end
    
    redirect_to :action => "edit", :id => @ticket    
  end

  # PUT /tickets/1
  # PUT /tickets/1.xml
  def update
    
    @ticket = Ticket.find(params[:id])
    

    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
    else
      flash[:notice] = 'Failed to update ticket.'      
    end        

    if params[:send_email]
      send_email
    end 
    
    redirect_to :action => "edit", :id => @ticket    
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.xml
  def destroy
    begin
      @ticket = Ticket.find(params[:id])
      @ticket.destroy
    rescue Exception => e
       #flash[:notice] = e.message
       flash[:notice] = msg_can_not_delete
    end 
    respond_to do |format|
      format.html { redirect_to(tickets_url) }
      format.xml  { head :ok }
    end 
  end
   
  def send_email

    @ticket = Ticket.find(params[:id])  
    @addressee = Staff.find(@ticket.assigned_id)
    if @addressee[:email] != ''
      if StaffMailer.ticket_email(@addressee, @ticket).deliver  
#      if  Notifier.deliver_email(@em)  
        flash[:notice] = flash[:notice] + " Email was successfully sent to " + @addressee[:name] + " (#{@addressee[:email]})" 
      else
        flash[:notice] = flash[:notice] + " Failed to send email to " + + @addressee[:name] + " (#{@addressee[:email]})"       
      end
    else
      flash[:notice] = flash[:notice] + " Failed to send email. #{@addressee[:name]} does not have email address"    
    end     
  end  
end
