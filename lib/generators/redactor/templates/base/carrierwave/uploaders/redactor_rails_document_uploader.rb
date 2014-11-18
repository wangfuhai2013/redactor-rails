# encoding: utf-8
class RedactorRailsDocumentUploader < CarrierWave::Uploader::Base
  include RedactorRails::Backend::CarrierWave

  # storage :fog
  storage :file

  def store_dir
    #"system/redactor_assets/documents/#{model.id}"
    "upload/redactor/" + model.created_at.strftime("%Y%m/%d/") + 
      "#{model.id}_" + Digest::SHA1.hexdigest(Time.now.to_s + 'redactor')[0,8].to_s
  end

  def extension_white_list
    RedactorRails.document_file_types
  end
end
