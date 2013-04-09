class Reportblockcontent < ActiveRecord::Base
	attr_accessible :admin_id, :content_id, :content_type, :email, :reason, :status

#  XXX make propper polymorphic association
	belongs_to :games
	belongs_to :developers
	belongs_to :companies

	# content type:
	GAME = 0
	DEVELOPER = 1
	COMPANY = 2
	
	# status:
	REPORTED = 0
	BLOCKED = 1
	LOCKED = 2
	CLEARED = 3
	DELETED = 4
	
	after_save :notify_administrators
	
  	def Reportblockcontent.create_from_string(ctype, cid, reason, content_status, email, admin_id)
	@rbcontent = Reportblockcontent.find_all_by_content_type_and_content_id(ctype, cid)

		if (content_status)
			if (@rbcontent and content_status != '0')
				@rbcontent.each do |rb|
					rb.delete
				end
			end

			if (content_status != '3')
				reason.strip!
				if reason == ''
					reason = nil
				end
				new_report = Reportblockcontent.new :content_type => ctype, :content_id => cid, :reason => reason, :status => content_status, :email => email, :admin_id => admin_id
				new_report.save

				# send notification mail to admin
				@recipients = User.find_by_admin(true)
				if not @recipients.nil?
					Reportmailer.report(@recipients, ctype, cid, reason).deliver
				end
			end
		end
	end

	def copy_without_references
		clone = Reportblockcontent.new
		clone.admin_id = self.admin_id
		clone.reason = self.reason
		clone.status = self.status
		clone.email = self.email
		clone.content_type = self.content_type
		return clone
	end
	
	private
	def notify_administrators
		admins = User.find_all_by_admin(true)
		admins.each do |admin|
			ReportMailer.new_report(admin, self).deliver
		end
	end
end
