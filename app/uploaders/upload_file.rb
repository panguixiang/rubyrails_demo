class UploadFile

  def self.checkImgFile(fileObj)
    return if fileObj.nil?
    size = fileObj.size
    return unless (fileObj.content_type.chomp).include? "image/"
    return unless fileObj.size<166000 #500kb
    return true
   #image/
    # img_ext = %w(png jpg jpeg gif bmp tiff)
    # img_ext.include?(fileObj.downcase)
  end


  def self.uploadImage(fileObj)
    return nil unless checkImgFile(fileObj)
    path = UPLOAD_FILE_PATH+"/pictures"
    if(!File.directory?(path))
      Dir.mkdir(path)
    end
    path+="/card/"
    if(!File.directory?(path))
      Dir.mkdir(path)
    end
    path = path+fileObj.original_filename
    File.open(path, "wb+") do |f|
      f.write(fileObj.read)
    end
    return "/pictures/card/"+fileObj.original_filename
  end


  def self.uploadPackage(fileObj)
    path = UPLOAD_FILE_PATH+"/apk/"
    if(!File.directory?(path))
      Dir.mkdir(path)
    end
    path = path+fileObj.original_filename.chomp
    File.open(path, "wb+") do |f|
      f.write(fileObj.read)
    end
    apkName = (fileObj.original_filename).downcase
    if apkName.include? "ipa"
      return ProUtils.resolveIPA(path,"/apk/"+fileObj.original_filename.chomp)
    elsif apkName.include? "apk"
      return ProUtils.resolveAPK(path,"/apk/"+fileObj.original_filename.chomp);
    end
    return nil
  end

end