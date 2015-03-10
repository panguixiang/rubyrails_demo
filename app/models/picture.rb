class Picture < ActiveRecord::Base

  def self.getPicListByType(type,size)
    if size.blank?
      Picture.select(:pic_url,:message,:link_url).where("pic_type = ?", Integer(type)).order(seque: :asc)
    else
      Picture.select(:pic_url,:message,:link_url).where("pic_type = ?", Integer(type)).limit(size).order(seque: :asc)
    end

  end

end
