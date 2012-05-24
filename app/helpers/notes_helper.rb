module NotesHelper
  def ticket_info(t)
       Status.find(Ticket.find(t).status_id).status_name + ' (' + Staff.find(Ticket.find(t).assigned_id).name + ')' + ' ' +           
       Type.find(Ticket.find(t).type_id).type_name + ' ' +    
       Component.find(Ticket.find(t).component_id).component_name
  end
end
