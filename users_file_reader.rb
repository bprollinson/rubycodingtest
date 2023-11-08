# Reads company data from JSON file
class UsersFileReader
  def initialize(file_name)
    @file_name=file_name
  end

  def read_users
    # Read user data from JSON file
    file_content = File.read(@file_name)
    json_data = JSON.parse(file_content)

    json_data.collect{|company_json| User.new(
      company_json["id"],
      company_json["first_name"],
      company_json["last_name"],
      company_json["email"],
      company_json["company_id"],
      company_json["email_status"],
      company_json["active_status"],
      company_json["tokens"],
      )}
  end
end
