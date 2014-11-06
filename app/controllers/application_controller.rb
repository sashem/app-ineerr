class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery
  
  after_filter :set_csrf_cookie_for_ng

  protect_from_forgery
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers
  
  # For all responses in this controller, return the CORS access control headers.
  
  def cors_set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = "1728000"
  end
  
  def cors_preflight_check
    if request.method == "OPTIONS"
      headers['Access-Control-Allow-Origin'] = 'http://localhost'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = %w{Origin Accept Content-Type X-Requested-With auth_token X-CSRF-Token}.join(',')
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  def check_session_empresas
    cookie=params["cookie"]
    if Empresa.where(:key=>cookie).exists?
      @empresa_id=Empresa.where(:key=>cookie).first.id
      params[:empresa_id]=@empresa_id
      ##sign_in(User.find_by(:session_key=>cookie))
      #@current_user=User.find_by(:session_key=>cookie)
      #p params[:my_user_id__]
      return
    end
    if !Empresa.where(:key=>cookie).exists?
      response={msge:{type: 'warning', msg:"Debe iniciar sesión primero"}}
      respond_to do |format|
        format.html{ render json: response }
      end
    end
  end
end
