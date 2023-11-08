# Reads company data from JSON file
class CompaniesFileReader
  def initialize(file_name)
    @file_name=file_name
  end

  def read_companies
    # Read company data from JSON file
    file_content = File.read(@file_name)
    json_data = JSON.parse(file_content)

    json_data.collect{|company_json| Company.new(
      company_json["id"],
      company_json["name"],
      company_json["top_up"],
      company_json["email_status"],
      )}
  end
end
