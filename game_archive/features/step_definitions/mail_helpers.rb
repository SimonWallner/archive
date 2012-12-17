def mail_sent?(email_hash)
  to = email_hash['to']
  from = email_hash['from']
  subject = email_hash['subject']

  mail = ActionMailer::Base.deliveries.last
  mail['to'].to_s.should == to unless ( to == nil || to == "" )
  mail['from'].to_s.should == from unless ( from == nil || from == "" )
  mail['subject'].to_s.should == subject unless ( subject == nil || subject == "" )
end