class MobileController < ApplicationController
  
  before_filter :authorize  
  layout 'iphone'  
  
  def index
    @ts = Array.new
    @filtered_tickets = {}
    
    @searchstring = "%#{params[:search]}%" 
    
    @notes = Note.find(:all,  :conditions => ['note_text like ? ', @searchstring])                  
    @tickets = Ticket.find(:all,  :conditions => ['summary like ? ', @searchstring]) 
     
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
      if @searchstring.strip == '%%' and @ts.size > 21
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

  def show
  end

end
