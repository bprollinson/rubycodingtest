# Formats a token report into a string
class TokenReportFormatter
  # Format a toekn report into a string
  def format_report(report)
    report_text = "\n"
    report.company_token_reports.each do
    |company_token_report|
      report_text += "\tCompany Id: #{company_token_report.company_id}\n"
      report_text += "\tCompany Name: #{company_token_report.company_name}\n"
      report_text += "\tUsers Emailed:\n"
      report_text += format_user_info(company_token_report.users_emailed)
      report_text += "\tUsers Not Emailed:\n"
      report_text += format_user_info(company_token_report.users_not_emailed)
      report_text += "\t\tTotal amount of top ups for #{company_token_report.company_name}: #{company_token_report.total_top_up_amount}\n"
      report_text += "\n"
    end

    report_text
  end

  private

  def format_user_info(users)
    user_text = ""

    users.each do
    |user|
      user_text += "\t\t#{user.last_name}, #{user.first_name}, #{user.email}\n"
      user_text += "\t\t  Previous token balance: #{user.old_token_balance}\n"
      user_text += "\t\t  New token balance: #{user.new_token_balance}\n"
    end

    user_text
  end
end
