# Report information representing token usage within a company
class CompanyTokenReport
  attr_reader :company_id, :company_name, :users_emailed, :users_not_emailed, :total_top_up_amount

  def initialize(company_id, company_name, users_emailed, users_not_emailed, total_top_up_amount)
    @company_id = company_id
    @company_name = company_name
    @users_emailed = users_emailed
    @users_not_emailed = users_not_emailed
    @total_top_up_amount = total_top_up_amount
  end
end
