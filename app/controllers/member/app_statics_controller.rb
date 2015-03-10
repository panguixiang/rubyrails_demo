class Member::AppStaticsController < FatherController
  before_filter :authenticate_member!

  # GET /app_statics
  # GET /app_statics.json
  def index
    @appList = AppProdu.getAppIdAndNameList current_member.id
  end

  # GET /app_statics/1
  # GET /app_statics/1.json
  def show
    @appList = AppProdu.getAppIdAndNameList current_member.id
    @appId=params[:id]
    render :index
  end

  # GET /app_statics/new
  def new
    @app_static = AppStatic.new
  end

  # GET /app_statics/1/edit
  def edit
  end

  # POST /app_statics
  # POST /app_statics.json
  def create
    @app_static = AppStatic.new(app_static_params)

    respond_to do |format|
      if @app_static.save
        format.html { redirect_to @app_static, notice: 'App static was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app_static }
      else
        format.html { render action: 'new' }
        format.json { render json: @app_static.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /app_statics/1
  # PATCH/PUT /app_statics/1.json
  def update
    respond_to do |format|
      if @app_static.update(app_static_params)
        format.html { redirect_to @app_static, notice: 'App static was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app_static.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /app_statics/1
  # DELETE /app_statics/1.json
  def destroy
    @app_static.destroy
    respond_to do |format|
      format.html { redirect_to app_statics_url }
      format.json { head :no_content }
    end
  end


  def appstatic
    list = AppStatic.queryAppStatics(current_member.id,params)
    respond_to do |format|
      format.json { render json: list.to_json}
    end
  end

  def exportCvs
    @list = AppStatic.queryAppStatics(current_member.id,params)
    csv_string = CSV.generate  do |csv|
      csv << createExportMean(params[:bill_type],@list,csv)
    end
    csv_string="\uFEFF#{csv_string}"
    send_data csv_string,
              :type=>"text/csv;charset=iso-8859-1;header=present",
              :disposition =>"attachment; filename=#{(Time.now).strftime("%Y%m%d%H%M%S%s")}"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_app_static
    @app_static = AppStatic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def app_static_params
    params[:app_static]
  end

  def createExportMean(bill_type,list,csv)
    if bill_type.blank?
      csv << ["日期/时间","收入","每千次有效展示收入","有效请求","有效填充","有效展示"]
      list.each do |u|
        thousand_income = 0
        thousand_income=format("%.2f",(u.incoming/u.display_count)*1000).to_f if u.display_count>0
        csv << [u.timed,u.incoming,thousand_income,u.request_count,u.fill_count,u.display_count]
      end
    elsif bill_type=='cpc'
      csv << ["日期/时间","收入","每千次有效展示收入","有效展示","点击次数","点击率"]
      list.each do |u|
        thousand_income = 0
        thousand_income=format("%.2f",(u.incoming/u.display_count)*1000).to_f if u.display_count>0
        click_rate=0
        click_rate=format("%.2f",(u.click_count.to_f/u.display_count)*100) if u.display_count>0
        csv << [u.timed,u.incoming,thousand_income,u.display_count,u.click_count,click_rate<<"%"]
      end
    else
      csv << ["日期/时间","收入","每千次有效展示收入","有效展示"]
      list.each do |u|
        thousand_income = 0
        thousand_income=format("%.2f",(u.incoming/u.display_count)*1000).to_f if u.display_count>0
        csv << [u.timed,u.incoming,thousand_income,u.display_count]
      end
    end
    return csv
  end
end