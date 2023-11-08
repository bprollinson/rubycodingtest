# User information as used within a token report
class TokenReportUser
  attr_reader :first_name, :last_name, :email, :old_token_balance, :new_token_balance

  def initialize(first_name, last_name, email, old_token_balance, new_token_balance)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @old_token_balance = old_token_balance
    @new_token_balance = new_token_balance
  end
end
