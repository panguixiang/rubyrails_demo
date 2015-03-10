class Member::MemberInfoController  < FatherController

  before_filter :authenticate_member!
  skip_filter :check_is_edit_memberInfo

  def create
    m_type = params[:m_type]
    @develInfo = DeveloperInfo.new(params[:developer_info])
    @develInfo.memberId=current_member.id
    @cardname=params[:cardname]
    @cardtype=params[:cardtype]
    @cardnum=params[:cardnum]
    if m_type=="2"
      respond_to do |format|
        if DeveloperInfo.insertAdverInfo(@develInfo,m_type)
          current_member.m_type=Integer(m_type)
          current_member.status=3
          format.html { redirect_to advertiser_indexs_path }
          format.json { head :no_content }
        else
          format.html { render 'member/login/completion' }
          format.json { render json: @develInfo.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if DeveloperInfo.insertInfo(@develInfo,m_type,@cardtype,@cardname,@cardnum)
          current_member.m_type=Integer(m_type)
          current_member.status=2
          format.html { redirect_to '/member/member_info/edit' }
          format.json { head :no_content }
        else
          format.html { render 'member/login/completion' }
          format.json { render json: @develInfo.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  def edit
    @info = DeveloperInfo.getDevelopInfoByMemberId(current_member.id);
    @developer_team = DeveloperTeam.getDevelopTeamByMemberIdAndLeader(current_member.id,1);
  end

  def updateBank
    side = params[:developer_team][:sidePic]
    sidePath = UploadFile.uploadImage side
    out = params[:developer_team][:outPic]
    outPath = UploadFile.uploadImage out
    @developer_team = DeveloperTeam.find(params[:developer_team][:id])
    @developer_team.setIsCheckUrl = 0
    @info = DeveloperInfo.getDevelopInfoByMemberId(@developer_team.memberId);
    respond_to do |format|
      @developer_team.setIsCheckBank = 1
      if @developer_team.update_attributes(:bankaddr=>params[:developer_team][:bankaddr],
                                 :banknum=>params[:developer_team][:banknum],
                                 :sideurl=>sidePath,:outsideurl=>outPath)
        Member.update(@developer_team.memberId, :status => 3)
        format.html { redirect_to '/member/login/developerIndex', notice: 'Bank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @developer_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateInfo
    @info = DeveloperInfo.find params[:developer_info][:id]
    @developer_team = DeveloperTeam.find(params[:teamId])
    respond_to do |format|
      if DeveloperInfo.updateInfo(params,@info)
        format.html { redirect_to '/member/login/developerIndex', notice: 'Bank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: :edit }
        format.json { render json: @info.errors, status: :unprocessable_entity }
      end
    end
  end

end