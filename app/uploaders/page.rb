class Page
  def initialize pageNum
    if pageNum.nil?
      @pageNum=1
    else
      @pageNum=Integer(pageNum)
    end
    if @pageNum==1
      @offSet = 0
    else
      @offSet = Integer(PAGE_SIZE)*(@pageNum-1)
    end
  end

  def pageCount count
    @totalCount = count
    @pageCount = count/Integer(PAGE_SIZE)
    if count == 0
      @pageCount=1
    end
    if count%Integer(PAGE_SIZE)>0
      @pageCount+=1
    end
    return @pageCount
  end

  def getPageNum
    @pageNum
  end
  def getOffSet
    @offSet
  end
  def getPageLimit
    PAGE_SIZE
  end

  def getPageCount
    @pageCount
  end
  def getTotalCount
    @totalCount
  end


end