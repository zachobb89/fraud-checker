require_relative 'user'
require 'time'

class FraudDetector
  attr_reader :last_name, :postcode, :card_number, :card_expiry

  def initialize(last_name, postcode, card_number, card_expiry)
    @last_name = last_name
    @postcode = postcode
    @card_number = card_number
    @card_expiry = card_expiry
    @users ||= []
    @users << User.new('Hobbs', 'E1 8NB', '4792213211111234', '02/20')
    @users << User.new('HOBBS', 'E18NB', '4792 21321111 1234', '2/20')
    @users << User.new('Hobbs', 'E1 8NB', '47922132 1111 1234', '2/2020')
    @users << User.new('hobbs', 'E1 8NB', '4792 2132 11111234', '2/20')
  end

  def fraudulent?
    user_instances = get_user_instances
    u_count = user_instances.count
    user_card_instances = get_user_card_instances(user_instances)
    u_c_count = user_card_instances
    user_postcode_instances = get_user_postcode_instances(user_instances)
    u_p_count = user_postcode_instances.count
    postcode_instances = get_postcode_instances
    p_count = postcode_instances.count
    c_count = get_card_and_expiry_instances(postcode_instances)
    if (u_count > 0 && u_p_count > 0) || (u_count > 0 && u_c_count > 0) || (p_count > 0 && c_count > 0)
      'Fraudulent'
    else
      @users << User.new(@last_name, @postcode, @card_number, @card_expiry)
      'Not fraudulent'
    end
  end

  private

  def get_user_instances
    @users.select { |user| user.last_name.casecmp(@last_name).zero? }
  end

  def get_user_card_instances(user_instances)
    inst = user_instances.select { |user| user.card_number.to_s[-4..-1].to_i == @card_number.to_s[-4..-1].to_i }
    get_card_with_expiry_instances(inst)
  end

  def get_card_with_expiry_instances(instances)
    count = 0
    m_y = @card_expiry.split('/')
    formatted_expiry = Time.parse(m_y[1] + '/' + m_y[0] + '/01')
    instances.each do |user|
      split = user.card_expiry.split('/')
      each_formatted = Time.parse(split[1] + '/' + split[0] + '/01')
      count += 1 if each_formatted == formatted_expiry
    end
    count
  end

  def get_user_postcode_instances(user_instances)
    user_instances.select { |user| user.postcode.gsub(/\s+/, '') == @postcode.gsub(/\s+/, '') }
  end

  def get_postcode_instances
    get_user_postcode_instances(@users)
  end
end
