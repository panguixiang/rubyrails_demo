class Member::AppAddController < FatherController
  before_filter :authenticate_member!

  def index1
    @app_prod = AppProdu.new
  end

  def new
    @app_prod = AppProdu.new(params[:app_produ])
    @app_prod.status=1
    @app_prod.publisherid=ProUtils.create32UUID
    @app_prod.memberId=current_member.id
    @app_prod.auto_value==2000
    respond_to do |format|
      if @app_prod.save
        format.html { redirect_to "/member/app_add/index2?id=#{@app_prod.id}"}
        format.json { head :no_content }
      else
        format.html { render "member/app_add/index1" }
        format.json { render json: @app_prod.errors, status: :unprocessable_entity }
      end
    end
  end

  def index2
    app_id = params[:id]
    unless app_id.to_i.to_s==app_id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    @app_prod = AppProdu.find(app_id)
    @adverList = Advertising.where("app_produ_id=?",app_id)
    @advertis = Advertising.new
    @advertis.app_produ_id =@app_prod['id']

  end

  def newAderTis
    @advertis = Advertising.create(params[:advertising])
    @advertis.status=1
    @advertis.innlinepid=ProUtils.create32UUID
    respond_to do |format|
      if @advertis.save
        format.json {render json: @advertis.to_json, :status => :ok}
      else
        format.json {render json: @advertis.errors.messages, status: 422 }
      end
    end
  end


  def index3
    approId = params[:approId]
    unless approId.to_i.to_s==approId
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    app = AppProdu.getAppByIdAndMemberId(Integer(approId), current_member.id)
    if app.blank?
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    @app = app[0]
  end

  def setAutoReflush
    app_id = params[:app_id]
    @app_prod = AppProdu.find(app_id)
    @app_prod.auto_reflush=params[:refreshType]
    @app_prod.auto_value=params[:refreshInterval]
    if @app_prod.save
      respond_to do |format|
        format.html { redirect_to '/member/appfilters?app_id='+params[:app_id], notice: "设置成功！" }
        format.json { head :no_content }
      end
    end
  end

  def edit
    app_id = params[:app_id]
    @appPro2 = AppProdu.find(app_id)
  end

  def update
    appProdu = AppProdu.new(params[:app_produ])
    AppProdu.update(appProdu.id,app_name:appProdu.app_name,
                     keyword:appProdu.keyword,app_type:appProdu.app_type,
                     isposition:appProdu.isposition,app_content:appProdu.app_content)
    respond_to do |format|
      format.html { redirect_to '/member/app_manager/index' }
      format.json { head :no_content }
    end
  end



end
