class Notifier < ActionMailer::Base

  def email(em)
    recipients em[:email_to]
    from       em[:email_from]    
    subject    em[:email_subject]
    body       em[:email_body]
  end    
end
