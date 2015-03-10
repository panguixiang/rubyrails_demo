require 'ipa_reader'
require 'zip/zip'
require 'ruby_apk'
class ProUtils

  def self.createTimeUUID(memberIdStr)
    return memberIdStr+(Time.now).strftime("%Y%m%d%H%M%S%s")
  end

  def self.resolveAPK(apkUrl,resultUrl)
    apk = Android::Apk.new(apkUrl)
    hash=Hash.new
    hash[:path] = resultUrl
    hash[:package_name] = apk.manifest.package_name
    hash[:version_code] = apk.manifest.version_code
    return hash
  end

  def self.resolveIPA(ipaUrl,resultUrl)
    ipa_file = IpaReader::IpaFile.new(ipaUrl)
    hash=Hash.new
    hash[:path] = resultUrl
    hash[:package_name] = ipa_file.bundle_identifier
    hash[:version_code] = ipa_file.version
    return hash
  end

  def self.create32UUID
    UUIDTools::UUID.timestamp_create.to_s.gsub('-','')
  end


end