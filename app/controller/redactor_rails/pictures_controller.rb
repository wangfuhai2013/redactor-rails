class RedactorRails::PicturesController < ApplicationController
  before_filter :redactor_authenticate_user!

  def index
    have_devise_user = RedactorRails.picture_model.new.has_attribute?(:"#{RedactorRails.devise_user_key}")
    @pictures = {}
    if(have_devise_user && redactor_current_user)
       @pictures = RedactorRails.picture_model.where({ RedactorRails.devise_user_key => redactor_current_user.id })
    end
    render :json => @pictures.to_json
  end

  def create
    @picture = RedactorRails.picture_model.new

    file = params[:file]
    @picture.data = RedactorRails::Http.normalize_param(file, request)
    if @picture.has_attribute?(:"#{RedactorRails.devise_user_key}") && redactor_current_user
      @picture.send("#{RedactorRails.devise_user}=", redactor_current_user)
      @picture.assetable = redactor_current_user
    end

    if @picture.save
      render :text => { :filelink => @picture.url }.to_json
    else
      render json: { error: @picture.errors }
    end
  end

  private
=begin
  #在RedactorRails::Devise中实现
  def redactor_authenticate_user!
    if RedactorRails.picture_model.new.has_attribute?(RedactorRails.devise_user)
      super
    end
  end
=end  
end
