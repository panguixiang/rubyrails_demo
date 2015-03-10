class Member::AppManagerController < FatherController
  before_filter :authenticate_member!
  def index
    status = params[:status]
    appName = params[:appName]
    pageNum = params[:pageNum]
    platform= params[:platform]
    @page = Page.new(pageNum)
    @appList=AppProdu.queryAppProd(status,current_member.id,appName,platform,@page)
    @page.pageCount(AppProdu.queryAppProdCount(status,current_member.id,appName,platform))
  end

  def setStatus
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    advertis = Advertising.find(id)
    if advertis.blank?
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    if advertis.status==1
      advertis.status=2
    elsif advertis.status==2
      advertis.status=1
    end
    respond_to do |format|
      if advertis.save
        format.html { redirect_to '/member/app_manager/index' }
      else
        format.json {render json: nil, status: 422 }
      end
    end
  end

  def app_push
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

  def app_details
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
    @appPro1 = AppProdu.find approId
    @adverList = Advertising.where("app_produ_id=?",Integer(approId))
    @advertis = Advertising.new
    @advertis.app_produ_id =Integer(approId)
    @count1 = Appfilter.count(:conditions=>{:app_produ_id=>approId,:filter_type=>1})
    @count2 = Appfilter.count(:conditions=>{:app_produ_id=>approId,:filter_type=>2})
    filter3=Appfilter.find_by_app_produ_id_and_filter_type(approId,3)
    unless filter3.blank?
      sss=filter3.filter_content
      arr= sss.split(",")
      @count3=arr.length
    else
      @count3=0
    end
    filter4=Appfilter.find_by_app_produ_id_and_filter_type(approId,4)
    unless filter4.blank?
      @dddd=filter4.filter_content
    else
      @dddd='0'
    end
    @app_prod = AppProdu.new
  end


  def set_status
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    advertis = Advertising.find(id)
    if advertis.blank?
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    if advertis.status==1
      advertis.status=2
    elsif advertis.status==2
      advertis.status=1
    end
    respond_to do |format|
      if advertis.save
        format.json {render json: advertis.to_json, :status => :ok}
      else
        format.json {render json: advertis.errors.messages, status: 422 }
      end
    end
  end



  def deleteAdvertising
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    respond_to do |format|
      if Advertising.delete(id)==1
        format.json {render json: nil, :status => :ok}
      else
        format.json {render json: nil, status: 422 }
      end
    end
  end

  def deleteApp
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    respond_to do |format|
      if AppProdu.deleteAppById(id)
        format.html { redirect_to '/member/app_manager/index' }
      else
        format.json {render json: nil, status: 422 }
      end
    end
  end

  def setStatus2
    id = params[:id]
    unless id.to_i.to_s==id
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    advertis = Advertising.find(id)
    if advertis.blank?
      respond_to do |format|
        format.json {render json: nil, status: 404 }
      end
    end
    if advertis.status==1
      advertis.status=2
    elsif advertis.status==2
      advertis.status=1
    end
    respond_to do |format|
      if advertis.save
        format.html { redirect_to "/member/app_manager/app_details?approId=#{advertis['app_produ_id']}" }
      else
        format.json {render json: nil, status: 422 }
      end
    end
  end

  def packageupload
    @app = AppProdu.find(params[:app_produ][:id])
    @app.status=2
    respond_to do |format|
      @app.setIsCheckPackage =1
      if @app.update(params[:app_produ])
        flash[:app_id]=@app.id
        format.html { redirect_to "/member/app_manager/upload_success"}
        format.json { head :no_content }
      else
        format.html { render :app_push }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload_success
    @app_id=flash[:app_id]
  end
end
