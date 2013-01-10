class Reportblockcontent < ActiveRecord::Base
  attr_accessible :admin_id, :content_id, :content_type, :email, :reason, :status
 
  belongs_to :games
  belongs_to :developers
  belongs_to :companies
  
# content_type: 0 => game 	1 => developer 	2 => company
# status: 		0 => report 1 => block		2 => lock
#
  def Reportblockcontent.create_from_string(ctype, cid, reason, content_status, email, admin_id)
	@rbcontent =Reportblockcontent.find_all_by_content_type_and_content_id(ctype,cid)
	
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
end
