class RedactorRails::DocumentsController < ApplicationController
  before_filter :redactor_authenticate_user!

  def index
    have_devise_user = RedactorRails.document_model.new.has_attribute?(:"#{RedactorRails.devise_user_key}")
    @documents = {}
    if(have_devise_user && redactor_current_user)
      @documents = RedactorRails.document_model.where({ RedactorRails.devise_user_key => redactor_current_user.id })
    end
    render :json => @documents.to_json
  end

  def create
    @document = RedactorRails.document_model.new

    file = params[:file]
    @document.data = RedactorRails::Http.normalize_param(file, request)
    if @document.has_attribute?(:"#{RedactorRails.devise_user_key}") && redactor_current_user
      @document.send("#{RedactorRails.devise_user}=", redactor_current_user)
      @document.assetable = redactor_current_user
    end

    if @document.save
      render :text => { :filelink => @document.url, :filename => @document.filename }.to_json
    else
      render json: { error: @document.errors }
    end
  end

end
