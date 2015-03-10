class Member::IntegralWallsController < FatherController
  before_filter :authenticate_member!
  # GET /companies
  # GET /companies.json
  def index
    @intelWalist = IntegralWall.where("memberId=?", current_member.id)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @integral_wall = IntegralWall.find(params[:id])
    @onlyShow = params[:onlyShow]
  end

  # GET /companies/new
  def new
    @integral_wall = IntegralWall.new
    # if current_user.company.nil?
    #   @company = Company.new
    # else
    #   redirect_to root_url, notice: 'You have joined  a company'
    # end
  end

  # GET /companies/1/edit
  def edit
    @integral_wall = IntegralWall.find(params[:id])
  end

  # POST /companies
  # POST /companies.json
  def create
    @integral_wall = IntegralWall.new(params[:integral_wall])
    @integral_wall.memberId = current_member.id
    set_default @integral_wall
    respond_to do |format|
      if @integral_wall.save
        format.html {redirect_to [:member, @integral_wall]}
        format.json { head :no_content }
      else
        @integral_wall.source=nil
        format.html { render "new" }
        format.json { render json: @integral_wall.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    @integral_wall ||= IntegralWall.find_by!(id: params[:id])
    unless @integral_wall
      format.html { render "edit" }
      format.json { render json: @integral_wall.errors, status: :unprocessable_entity }
    end
    respond_to do |format|
      if @integral_wall.update_attributes(params[:integral_wall])
        format.html {redirect_to [:member, @integral_wall]}
        format.json { head :ok }
      else
        @integral_wall.source=nil
        format.html { render "edit" }
        format.json { render json: @integral_wall.errors, status: :unprocessable_entity }
      end
    end
  end

  def run
    @integral_wall = IntegralWall.find(params[:id])
    if @integral_wall.blank?
      respond_to do |format|
        format.html { redirect_to member_integral_walls_path, notice: "应用不存在，操作失败！" }
        format.json { head :no_content }
        return
      end
    end
    respond_to do |format|
      if @integral_wall.status==1
        newStatus=2
        message="已经暂停"
      end
      if @integral_wall.status==2
        newStatus=1
        message="已经恢复运行"
      end
      if @integral_wall.update_attributes(:status=>newStatus)
        format.html { redirect_to member_integral_walls_path, notice: "媒体 #{@integral_wall.app_name} #{message}！" }
        format.json { head :no_content }
      end
    end
  end
  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @integral_wall = IntegralWall.find(params[:id])
    @integral_wall.destroy
    respond_to do |format|
      format.html { redirect_to member_integral_walls_path, notice: "媒体 #{@integral_wall.app_name} 已被删除！" }
      format.json { head :no_content }
    end
  end


  def uploadapk
    obj = params[:Filedata]
    hash = nil
    if obj
     hash = UploadFile.uploadPackage(obj)
    end
    respond_to do |format|
        format.json { render json: hash.to_json}
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  # def set_integral_wall
  #   @integral_wall = IntegralWall.find(params[:id])
  # end
  #
  # # Never trust parameters from the scary internet, only allow the white list through.
  # def integral_wall_params
  #   params.require(:integral_walls)
  #   .permit(:app_name, :platform, :app_type, :status, :checkstatus, :source, :package_type, :adver_type, :active_income,
  #           :currency_name, :exchange_rate, :ishow_balance)
  # end
  def set_default integral_wall
    integral_wall.publisherid=ProUtils.create32UUID
    if integral_wall.platform=='android'
      integral_wall.adver_type=nil
      integral_wall.package_type=nil
    elsif integral_wall.platform=='ios' and integral_wall.package_type==1
      integral_wall.package_name=nil
      integral_wall.version_code=nil
    end
  end
end
