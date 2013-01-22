class Reportmailer < ActionMailer::Base
  default from: "admin@example.com"
  
  def report(ctype, cid, reason, sent_at = Time.now)
      @subject = "Report content notification"
      @recipients = User.find_by_admin(true)
      @from = 'no-reply@example.com'
      @sent_on = sent_at
	  @reason = reason.nil? ? "" : reason
	  mail(:to => @recipients.email, :subject => @subject, :text => "An article of type " + ctype.to_s + " with ID " + cid.to_s + " has been reported for the following reason: " + reason)
     
   end
end
