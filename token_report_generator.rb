# Aggregates company, user and token data into a report
class TokenReportGenerator
  def initialize(companies_file_reader, users_file_reader)
    @companies_file_reader = companies_file_reader
    @users_file_reader = users_file_reader
  end

  # Generate the token report
  def generate_report
    companies = @companies_file_reader.read_companies
    users = @users_file_reader.read_users

    active_users_by_company = hash_active_users_by_company(users)
    sorted_companies = companies.sort_by(&:id)
    token_report = TokenReport.new

    sorted_companies.each {
      |company|
      company_users = active_users_by_company[company.id]
      if company_users == nil
        company_users = []
      end
      sorted_company_users = company_users.sort_by(&:last_name)

      users_emailed = filter_users_emailed(company.email_status, sorted_company_users)
      users_not_emailed = filter_users_not_emailed(company.email_status, sorted_company_users)

      formatted_users_emailed = format_users(company.top_up, users_emailed)
      formatted_users_not_emailed = format_users(company.top_up, users_not_emailed)

      total_user_count = formatted_users_emailed.length + formatted_users_not_emailed.length

      if total_user_count > 0
        company_token_report = CompanyTokenReport.new(
          company.id,
          company.name,
          formatted_users_emailed,
          formatted_users_not_emailed,
          total_user_count * company.top_up
        )
        token_report.add_company_report(company_token_report)
      end
    }

    token_report
  end

  private

  def hash_active_users_by_company(users)
    active_users_by_company = Hash.new
    users.each {
      |user|
      if user.active_status
        user_list = active_users_by_company[user.company_id]
        if user_list == nil
          user_list = []
        end
        user_list.append(user)
        active_users_by_company[user.company_id] = user_list
      end
    }

    active_users_by_company
  end

  def filter_users_emailed(company_email_status, users)
    if company_email_status
      users.select{|user| user.email_status}
    else
      []
    end
  end

  def filter_users_not_emailed(company_email_status, users)
    if company_email_status
      users.select{|user| !user.email_status}
    else
      users
    end
  end

  def format_users(company_top_up, users)
    formatted_users = []

    users.each{
      |user|
      formatted_users.append(
        TokenReportUser.new(
          user.first_name,
          user.last_name,
          user.email,
          user.tokens,
          user.tokens + company_top_up,
          )
      )
    }

    formatted_users
  end
end
