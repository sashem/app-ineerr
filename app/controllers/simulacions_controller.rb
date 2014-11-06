#encoding: utf-8
class SimulacionsController < ApplicationController
  #before_action :set_Empresa, only: [:show, :edit, :update, :destroy]
  before_filter :set_headers
  before_filter :check_session_empresas
  #before_filter :check_admin, :except => [:login, :fetch, :update_datos, :fetch_all,:search]
  
  def index
    @Empresas = Empresa.all
  end
  
  def fetch_all
    respond_to do |format|
        format.html{ render json: Empresa.all}
    end
  end
  
  def fetch
    #p Empresa.where(:key=>params["cookie"]).first.dato
    respond_to do |format|
        format.html{ render json: Empresa.where(:key=>params["cookie"]).first}
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
  def simulate
    #parámetros disponibles: tecnologia:int, consumo:double, consumo_electrico:double, cop:double, eficiencia:double, combustible:int, precio_combustible:double, precio_electricidad:double
    # superficie:double, superficie:double, superficie_lugar:int, unidad_consumo:int, unidad_consumo_electrico:int, unidad_precio_combustible:int,rubro:string
    # tecnologias: {1: UFPC, 2:FPC, 3:ETC, 4:PTC}
    # combustible: {1: CARBÓN, 2:DIESEL, 3:FUEL OIL N°6, 4:GNL, 5:GLP, 6:LEÑA, 7:PELETS_MADERA}
    # superficie_lugar: {1:techo, 2:suelo}
    # unidad_consumo: {1:ton/año, 2:kg/año, 3:litros/año, 4:m3/año}
    # unidad_consumo_electrico: {1:mW/año, 2:kW/año}
    # unidad_precio_combustible {1:$/ton, 2:$/kg, 3:$/lt, 4:$/m3}
    areas=Array.new
    ahorros=Array.new
    fracciones=Array.new
    precios=Hash.new
    precios["UFPC"]=Array.new
    precios["FPC"]=Array.new
    precios["ETC"]=Array.new
    precios["PTC"]=Array.new
    sim=params["simulacion"] 
    tir_esperada=0.1
    anos_evaluacion=10
    
    
    g_anual=1797 #kWh_año/m2
    
    region=params["region"]
    if datos_radiacion=Radiacion.where(:nombre_region=>region).first
      if sim["longitud"]>=datos_radiacion.long_sep
        g_anual=datos_radiacion.rad_cord
      else
        datos_radiacion.rad_costa
      end
    end
    p g_anual
    
    latr = sim["latitud"].to_f*Math::PI/180
    lonr = sim["longitud"].to_f*Math::PI/180
    f_d=1/(Math.sin(Math::PI/2-latr.abs)/Math.tan(Math::PI/2-latr.abs-23.5*Math::PI/180)+Math.cos(Math::PI/2-latr.abs))
    datos_rubro=Rubro.where(:rubro_id=>sim["rubro"]).first
    ases=Costo.where(:coef=>"A").first
    bses=Costo.where(:coef=>"B").first
    p sim["combustible"]
    case sim["combustible"].to_i #pci en kWh/kg, densidad en kg/m3
    when 1 #carbóns
        pci= 7.17
    when 2 #diesel
        pci= 11.95
        densidad = 840
    when 3 #fuel oil N°6
        pci= 11.22
        densidad = 946
    when 4 #GNL
        pci= 9.78
        densidad = 0.8
    when 5 #GLP
        pci= 13.14
        densidad = 550
    when 6 #leña
        pci= 3.61
    when 7 #pelets_madera
        pci= 5
    end
    
    case sim["unidad_consumo"] #consumo en kWh_año
    when 1 #ton/año
        consumo=sim["consumo"].to_f*pci*1000
    when 2 #kg/año
        consumo=sim["consumo"].to_f*pci
    when 3 #litros/año
        consumo=sim["consumo"].to_f*pci*densidad/1000
    when 4 #m3/año
        consumo=sim["consumo"].to_f*pci*densidad
    end
    
    case sim["unidad_precio_combustible"].to_i #precio en $/kg
    when 1 #$/ton
        precio=sim["precio_combustible"].to_f/1000
    when 2 #$/kg
        precio=sim["precio_combustible"].to_f
    when 3 #$/litros
        precio=sim["precio_combustible"].to_f*1000/densidad
    when 4 #$/m3
        precio=sim["precio_combustible"].to_f/densidad
    end
    
    precio_kwh=precio/pci
    
    demanda=consumo*datos_rubro.QQT*sim["eficiencia"].to_f/100 #kWh_año
    
    
    superficie=[sim["superficie"].to_f,demanda*0.8/(g_anual*0.5)].min
    
    j=0
    for k in 0..9
      j=k+2
      p fibonacci(j)
      areas[k]=superficie*fibonacci(j)/89
    end
    
    for i in 0..areas.count-1
        area=areas[i]
        
        area2=area*f_d
        g=g_anual*area2 #kWh_año/m2 neto del campo
        
        
        # PARA CALOR #####################
        fs_UFPC=fsc(g,demanda,datos_rubro.C_UFPC_B,datos_rubro.C_UFPC_C)
        fs_FPC=fsc(g,demanda,datos_rubro.C_FPC_B,datos_rubro.C_FPC_C)
        fs_ETC=fsc(g,demanda,datos_rubro.C_ETC_B,datos_rubro.C_ETC_C)
        fs_PTC=fsc(g,demanda,datos_rubro.C_PTC_B,datos_rubro.C_PTC_C)
        
        #p "g="+g.to_s
        #p "B_FPC="+datos_rubro.C_FPC_B.to_s
        #p "C_FPC="+datos_rubro.C_FPC_C.to_s
        #p "fs_UFPC="+fs_UFPC.to_s
        #p "fs_FPC="+fs_FPC.to_s
        #p "fs_ETC="+fs_ETC.to_s
        #p "fs_PTC="+fs_PTC.to_s
        #p "demanda="+demanda.to_s
        
        
        aporte_UFPC=fs_UFPC*demanda #kWh_año
        aporte_FPC=fs_FPC*demanda
        aporte_ETC=fs_ETC*demanda
        aporte_PTC=fs_PTC*demanda
        
        case sim["superficie_lugar"].to_i
        when 1
           coef_suelo=1
        when 2
           coef_suelo=0.8
        end
        
        case sim["rubro"]
        when 1330
          inv_UFPC=ases.m_inv_UFPC*area**bses.m_inv_UFPC
          inv_FPC=ases.m_inv_FPC*area**bses.m_inv_FPC*coef_suelo
          inv_UFPC=ases.m_inv_ETC*area**bses.m_inv_ETC*coef_suelo
          inv_UFPC=ases.m_inv_PTC*area**bses.m_inv_PTC*coef_suelo
          coef_mina=2.5
        else
          inv_UFPC=ases.inv_UFPC*area**bses.inv_UFPC*coef_suelo
          inv_FPC=ases.inv_FPC*area**bses.inv_FPC*coef_suelo
          inv_ETC=ases.inv_ETC*area**bses.inv_ETC*coef_suelo
          inv_PTC=ases.inv_PTC*area**bses.inv_PTC*coef_suelo
          coef_mina=1
        end
        
        mant_UFPC=ases.mant_UFPC*area**bses.mant_UFPC*coef_mina
        mant_FPC=ases.mant_FPC*area**bses.mant_FPC*coef_mina
        mant_ETC=ases.mant_ETC*area**bses.mant_ETC*coef_mina
        mant_PTC=ases.mant_PTC*area**bses.mant_PTC*coef_mina
        
        vol_acum=area2*75/1000
        acum=ases.acum*vol_acum**bses.acum
        
        inv_total_UFPC=inv_FPC*area2+acum*vol_acum
        inv_total_FPC=inv_FPC*area2+acum*vol_acum
        inv_total_ETC=inv_ETC*area2+acum*vol_acum
        inv_total_PTC=inv_PTC*area2+acum*vol_acum
        
        #p "A="+ases.inv_FPC.to_s
        #p "B="+bses.inv_FPC.to_s
        #p "A_acu="+ases.acum.to_s
        #p "B_acu="+bses.acum.to_s
        #p "A_mant="+ases.mant_FPC.to_s
        #p "B_mant="+bses.mant_FPC.to_s
        #p "inv_FPC="+inv_FPC.to_s
        #p "mant_FPC="+mant_FPC.to_s
        #p "acum="+acum.to_s
        #p "area="+area.to_s
        #p "area2="+area2.to_s
        #p "produccion="+aporte_FPC.to_s
        #p "vol_acum="+vol_acum.to_s
        #p "inversion="+inversion.to_s
        precio_UFPC=precio_E_ESCO(inv_total_UFPC,aporte_UFPC,mant_UFPC*area2.to_f,tir_esperada,anos_evaluacion)
        precios["UFPC"].push precio_UFPC
        precio_FPC=precio_E_ESCO(inv_total_FPC,aporte_FPC,mant_FPC*area2.to_f,tir_esperada,anos_evaluacion)
        precios["FPC"].push precio_FPC
        precio_ETC=precio_E_ESCO(inv_total_ETC,aporte_ETC,mant_ETC*area2.to_f,tir_esperada,anos_evaluacion)
        precios["ETC"].push precio_ETC
        precio_PTC=precio_E_ESCO(inv_total_PTC,aporte_PTC,mant_PTC*area2.to_f,tir_esperada,anos_evaluacion)
        precios["PTC"].push precio_PTC 
        
        
        ahorro_UFPC=precio_UFPC/precio_kwh-1<0?-(precio_UFPC/precio_kwh-1)*100:0
        ahorro_FPC=precio_FPC/precio_kwh-1<0?-(precio_FPC/precio_kwh-1)*100:0
        ahorro_ETC=precio_ETC/precio_kwh-1<0?-(precio_ETC/precio_kwh-1)*100:0
        ahorro_PTC=precio_PTC/precio_kwh-1<0?-(precio_PTC/precio_kwh-1)*100:0
        #aux=[ahorro_UFPC,ahorro_FPC,ahorro_ETC,ahorro_PTC]
        ahorros_x={:x=>area,:UFPC=>ahorro_UFPC,:FPC=>ahorro_FPC,:ETC=>ahorro_ETC,:PTC=>ahorro_PTC}
        fracciones_x={:x=>area,:UFPC=>fs_UFPC*100,:FPC=>fs_FPC*100,:ETC=>fs_ETC*100,:PTC=>fs_PTC*100}
        ahorros.push ahorros_x
        fracciones.push fracciones_x
    end
    
     respond_to do |format|
        format.html { render json: {ahorros:ahorros,fracciones:fracciones} }
    end
  end
  
  def fibonacci(n)
        if (n == 0 || n == 1)
          return n
        else
          return fibonacci(n - 1) + fibonacci(n - 2)
        end
  end
  
  def precio_E_ESCO(inv, qt, ct, d, t)
    e_total=0
    costos_total=0
    for tt in 1..t
        costos_total=costos_total+ct/(1+d)**tt
        e_total=e_total+qt/(1+d)**tt
    end
    #p e_total
    return (inv+costos_total)/e_total
  end
  
  def fsc(g,d,b,c)
    return -b.to_f/(g.to_f/d.to_f+b.to_f/c.to_f)+c.to_f
  end
  
  # PATCH/PUT /Empresas/1
  # PATCH/PUT /Empresas/1.json
  def create
    @Empresa = Empresa.find(params[:empresa_id])
    p simulacion_params[:id]
    if simulacion_params[:id]!=nil
      respond_to do |format|  
        format.html { render json: 1 and return}
      end
    end
    simulacion=@Empresa.simulacions.new(simulacion_params)
    respond_to do |format|
      if simulacion.save
        format.html { render json: {simulacion:simulacion}}
      else
        format.html { render action: simulacion.errors }
      end
    end
  end
  def update
    respond_to do |format|
      if @Empresa.update(empresa_params)
        format.html { redirect_to @Empresa, notice: 'Empresa was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @Empresa.errors, status: :unprocessable_entity }
      end
    end
  end

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
  # if request.headers["HTTP_ORIGIN"] && /{^https?:\/\/(.*)\.some\.site\.com$/i.match(request.headers["HTTP_ORIGIN"])
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
    def simulacion_params
      params.require(:Simulacion).permit(:id,:nombre,:latitud,:longitud,:empresa_id,:antiguedad, :recuperacion, :consumo_electrico_general, :unidad_consumo_electrico_general,:consumo_minimo,:unidad_consumo_minimo,:combustible,:tecnologia,:consumo,:consumo_electrico,:cop,:eficiencia,:precio_combustible,:precio_electricidad,:superficie,:superficie_lugar,:unidad_consumo,:unidad_consumo_electrico,:unidad_precio_combustible,:rubro)
    end
end
