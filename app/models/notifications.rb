class Notifications < ActiveRecord::Base

  def self.queryNotification_size(memberId, size)
    Notifications.where("memberId=?",Integer(memberId)).order(:status, created_at: :desc).limit(size)
  end
  def self.unreader_size(memberId)
    Notifications.where("memberId=? AND status=?",Integer(memberId),1)
  end

end
