# Report information representing token usage across multiple companies
class TokenReport
  attr_reader :company_token_reports

  def initialize
    @company_token_reports = []
  end

  def add_company_report(company_token_report)
    @company_token_reports.append(company_token_report)
  end
end
