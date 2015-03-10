class Member::NotificationController < FatherController
  before_filter :authenticate_member!
  def note
    memberId = current_member.id
    @notificationList=Notifications.queryNotification_size(memberId, 20)
    current_member.m_type==1
  end

  def saveStatus
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    notification = Notifications.find(id)
    if notification.blank?
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    if notification.status==1
      notification.status=2
      respond_to do |format|
        if notification.save
          unless session[:unreadCount].blank?
            session[:unreadCount]=session[:unreadCount]-1
          end
          format.json {render json: notification.to_json, :status => :ok}
        else
          format.json {render json: nil, status: 422 }
        end
      end

    end

  end







end
