require 'json'
require './company.rb'
require './company_token_report.rb'
require './companies_file_reader.rb'
require './token_report.rb'
require './token_report_formatter.rb'
require './token_report_generator.rb'
require './token_report_user.rb'
require './user.rb'
require './users_file_reader.rb'

token_report_generator = TokenReportGenerator.new(
  CompaniesFileReader.new("companies.json"),
  UsersFileReader.new("users.json"),
)
report = token_report_generator.generate_report
token_report_formatter = TokenReportFormatter.new
puts token_report_formatter.format_report(report)