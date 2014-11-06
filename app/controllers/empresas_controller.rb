#encoding: utf-8
class EmpresasController < ApplicationController
  #before_action :set_Empresa, only: [:show, :edit, :update, :destroy]
  before_filter :set_headers
  before_filter :check_session_empresas, :except => [:login,:create]
  #before_filter :check_admin, :except => [:login, :fetch, :update_datos, :fetch_all,:search]
  def index
    @Empresas = Empresa.all
  end
  def login
    aux = params["Empresa"]
    empresa_finded=Empresa.where(email: aux["email"],pass: aux["pass"].encrypt).first
    if empresa_finded
      key=SecureRandom.base64
      cookie=empresa_finded.id.to_s.encrypt(:symmetric, :password=>key)+" "+key
      empresa_finded.key=cookie
      if empresa_finded.save and empresa_finded
        response={cookie:cookie}
      end
    end
    if !empresa_finded
        response=-1
    end
    respond_to do |format|
        format.html{ render json: response }
    end
  end
  
  def fetch_all
    respond_to do |format|
        format.html{ render json: Empresa.all}
    end
  end
  def update
    empresa=Empresa.where(:key=>params["cookie"]).first
    p empresa
    respond_to do |format|
      if empresa.update(empresa_params)
        format.html{ render json: empresa, serializer: EmpresaSerializer, root: false}
      else
        
      end
        
    end 
  end
  def fetch
    #p Empresa.where(:key=>params["cookie"]).first.dato
    empresa=Empresa.where(:key=>params["cookie"]).first
    respond_to do |format|
        format.html{ render json: empresa, serializer: EmpresaSerializer, root: false}
    end  
  end
  
  def update_datos
    parametros=params["Empresa"]
    empresa=Empresa.where(:key=>params["cookie"]).first
    empresa_updated=Empresa.update(Empresa_params)
    response={msge:{type: 'success', msg:"Sus Datos han sido actualizados"}}
    respond_to do |format|
        format.html{ render json: response }
    end
  end

  # GET /Empresas/1
  # GET /Empresas/1.json
  def show
  end

  # GET /Empresas/new
  def new
    @Empresa = Empresa.new
  end

  # GET /Empresas/1/edit
  def edit
  end

  # POST /Empresas
  # POST /Empresas.json
  def create
    @Empresa = Empresa.new(empresa_params)
    @Empresa.pass=@Empresa.pass.encrypt
    respond_to do |format|
      if @Empresa.save
        format.html { render json: {id:@Empresa.id}}
      else
        #p @Empresa.errors
        format.html { render json: {errores:@Empresa.errors}}
      end
    end
  end

  # PATCH/PUT /Empresas/1
  # PATCH/PUT /Empresas/1.json
  # DELETE /Empresas/1
  # DELETE /Empresas/1.json
  def destroy
    @Empresa.destroy
    respond_to do |format|
      format.html { redirect_to Empresas_url }
      format.json { head :no_content }
    end
  end

 def set_headers
  puts 'ApplicationController.set_headers'
  if request.headers["HTTP_ORIGIN"]     
  # better way check origin
  # if request.headers["HTTP_ORIGIN"] && /^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
    headers['Access-Control-Allow-Origin'] = request.headers["HTTP_ORIGIN"]
    headers['Access-Control-Expose-Headers'] = 'ETag'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, DELETE, OPTIONS, HEAD'
    headers['Access-Control-Allow-Headers'] = '*,x-requested-with,Content-Type,If-Modified-Since,If-None-Match,Auth-User-Token'
    headers['Access-Control-Max-Age'] = '86400'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end
end    

  private
    # Use callbacks to share common setup or constraints between actions.
    #def set_Empresa
    #  @Empresa = Empresa.find(params[:id])
    #end

    # Never trust parameters from the scary internet, only allow the white list through.
    def empresa_params
      params.require(:Empresa).permit(:id,:nombre, :contacto, :email, :pass, :key, simulacions_attributes:[:empresa_id,:tecnologia,:consumo,:consumo_electrico,:cop,:eficiencia,:precio_combustible,:precio_electricidad,:superficie,:superficie_lugar,:unidad_consumo,:unidad_consumo_electrico,:unidad_precio_combustible,:rubro])
    end
end
