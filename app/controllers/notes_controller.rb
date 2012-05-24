class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  
  before_filter :authorize  
  
  layout "desktop"
  
  def index
    @ts = Array.new
    @filtered_tickets = {}
    @assignedid = ''
    @statusid = ''
    
    @searchstring = "%#{params[:search]}%" 
    
    if "#{params[:assigned]}" != ''
      session['assigned']= "#{params[:assigned]}"      
      @assignedid = Staff.find(:first, :conditions => ['name = ? ', "#{params[:assigned]}"]).id.to_s
    else
      session['assigned']= nil         
    end
    
    if "#{params[:status]}" != ''  
      session['status']= "#{params[:status]}"        
      @statusid = Status.find(:first, :conditions => ['status_name = ? ', "#{params[:status]}"]).id.to_s 
    else
      session['status']= nil   
    end  
    
    if @assignedid == '' and @statusid == ''
      @notes = Note.where('note_text like ? ', @searchstring)                  
      @tickets = Ticket.where('summary like ? ', @searchstring) 
    elsif  @assignedid != '' and @statusid != ''
      @filtered_tickets = Ticket.where('assigned_id = ? and status_id = ?', @assignedid, @statusid)    
      @notes = Note.where('note_text like ?  and ticket_id in (?)', @searchstring, @filtered_tickets)                     
      @tickets = Ticket.where('summary like ? and id in (?)', @searchstring, @filtered_tickets) 
    elsif  @assignedid != '' and @statusid == ''
      @filtered_tickets = Ticket.where('assigned_id = ? ', @assignedid)     
      @notes = Note.where('note_text like ?  and ticket_id in (?)', @searchstring, @filtered_tickets)                     
      @tickets = Ticket.where('summary like ? and id in (?)', @searchstring, @filtered_tickets)  
    elsif  @assignedid == '' and @statusid != ''
      @filtered_tickets = Ticket.where('status_id = ?', @statusid)     
      @notes = Note.where('note_text like ?  and ticket_id in (?)', @searchstring, @filtered_tickets)                     
      @tickets = Ticket.where('summary like ? and id in (?)', @searchstring, @filtered_tickets)     
    end
     
    @notes.each do |n|
      @ts.push(n.ticket_id)
    end
    
    @tickets.each do |t|
      @ts.push(t.id)
    end
       
    if @ts
      @ts.uniq!
      @ts.sort!
      @ts.reverse!
      if @searchstring.strip == '%%' and @assignedid == '' and @statusid == '' and @ts.size > 21
        @ts.slice!(20, @ts.size)
      end 
    end
                                                        
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ts }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @note = Note.new(params[:note])

      if @note.save
        flash[:notice] = 'Note was successfully created.'
      else
        flash[:notice] = 'Failed to create note.'   
      end
      redirect_to :controller => 'tickets', :action => "edit", :id => @note.ticket_id
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      flash[:notice] = 'Note was successfully updated.'
    else
      flash[:notice] = 'Failed to update note.'      
    end
    redirect_to :controller => 'tickets', :action => "edit", :id => @note.ticket_id
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @t_id = @note.ticket_id
    begin
      @note.destroy
      flash[:notice] = 'Note was successfully deleted.'      
    rescue
       flash[:notice] = msg_can_not_delete
    end  
    redirect_to :controller => 'tickets', :action => "edit", :id => @t_id      
  end
end
