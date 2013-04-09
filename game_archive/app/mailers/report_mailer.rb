class ReportMailer < ActionMailer::Base
	default from: "admin@example.com"
	
	def new_report(recipient, report)
		@subject = '[Archive] New Content Report!'
		@from = 'no-reply@gamelab.at'
		@reason = report.reason
		@reporter = report.email
		
		if (report.content_type == Reportblockcontent::GAME)
			@title = Game.find(report.content_id).title
		elsif (report.content_type == Reportblockcontent::COMPANY)
			@title = Company.find(report.content_id).name
		elsif (report.content_type == Reportblockcontent::DEVELOPER)
			@title = Developer.find(report.content_id).name
		end
	
		@name = recipient.firstname
		mail(:from => @from, :to => recipient.email, :subject => @subject)
	end
end
