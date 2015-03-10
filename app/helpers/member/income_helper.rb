module Member::IncomeHelper
  def incomeTotal(incomeList)
    return 0.000 if incomeList.blank?
    total=0.000;
    incomeList.each do |obj|
      total+=(obj.cpc+obj.cpm+obj.intewall)
    end
    return total
  end
end
