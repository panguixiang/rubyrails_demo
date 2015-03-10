class Member::AppfiltersController < FatherController
  before_filter :authenticate_member!

  # GET /appfilters
  # GET /appfilters.json
  def index
    type=params[:type]
    app_id = params[:app_id]
    @tag = params[:tag]
    @appPro = AppProdu.find app_id unless app_id.blank?
    appfiterList = Appfilter.where("app_produ_id=?",app_id)
    @urlFilters=Array.new
    @keyworldFilters=Array.new
    @assortFilter=""
    @originalFilter=""
    @appfilter = Appfilter.new
    @appfilter.app_produ_id=app_id
    unless appfiterList.blank?
      appfiterList.each do |f|
        if f.filter_type==1
          @urlFilters<<f
        elsif f.filter_type==2
          @keyworldFilters<<f
        elsif f.filter_type==3
          @assortFilter=f.filter_content if f.filter_content
        else f.filter_type==4
          @originalFilter=f.filter_content if f.filter_content
        end
      end
    end

  end

  def show
  end

  # GET /appfilters/new
  def new

  end

  # GET /appfilters/1/edit
  def edit
  end

  def create
    appfilter = Appfilter.new(params[:appfilter])
    respond_to do |format|
      if Appfilter.saveOrUpdate appfilter
        format.json {render json: appfilter.to_json, :status => :ok }
        format.json { head :no_content }
      else
        format.html { render "new" }
        format.json { render json: appfilter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appfilters/1
  # PATCH/PUT /appfilters/1.json
  def update
    respond_to do |format|
      if @appfilter.update(appfilter_params)
        format.json { head :no_content }
      else
        format.json { head :no_content, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appfilters/1
  # DELETE /appfilters/1.json
  def destroy
    appfilter = Appfilter.find(params[:id])
    respond_to do |format|
      if appfilter.blank?
        format.json {head :no_content, status: :unprocessable_entity}
      elsif appfilter.destroy
        count = Appfilter.count(:conditions=>{:app_produ_id=>appfilter.app_produ_id,:filter_type=>appfilter.filter_type})
        format.json {render text: count, :status => :ok}
        format.json { head :no_content }
      else
        format.json {head :no_content, status: :unprocessable_entity }
      end
    end
  end


  def batchDestory
    str=params[:id]
    arr = str.split(",")
    id=arr[0]
    appfilter = Appfilter.find(id)
    respond_to do |format|
      if Appfilter.delete_all(["id in (?)", arr])
        count = Appfilter.count(:conditions=>{:app_produ_id=>appfilter.app_produ_id,:filter_type=>appfilter.filter_type})
        format.json {render text: count, :status => :ok}
        format.json { head :no_content }
      else
        format.json {head :no_content, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appfilter
      @appfilter = Appfilter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appfilter_params
      params[:appfilter]
    end
end
