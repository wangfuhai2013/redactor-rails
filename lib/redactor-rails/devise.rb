module RedactorRails
  module Devise
    def redactor_authenticate_user!
      #authenticate_user!
      ret = false
      ret = true if session[:user_id]
      ret
    end

    def redactor_current_user
      #默认为空，不按用户保存文件数据，不提供查询功能，可在applicationController中覆盖
      nil
    end
  end
end