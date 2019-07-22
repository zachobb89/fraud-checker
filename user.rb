class User
  attr_reader :last_name, :postcode, :card_number, :card_expiry

  def initialize(last_name, postcode, card_number, card_expiry)
    @last_name = last_name
    @postcode = postcode
    @card_number = card_number
    @card_expiry = card_expiry
  end
end
