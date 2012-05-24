    ActionMailer::Base.smtp_settings = {  
  		:address  => "mailhost.odshp.com",
  		:port  => 25, 
  		:domain  => 'www.odscompanies.com'
    }  
      
    ActionMailer::Base.default_url_options[:host] = "localhost:3000"  