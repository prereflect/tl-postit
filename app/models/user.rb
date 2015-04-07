class User < ActiveRecord::Base
  include Sluggable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  sluggable_column :username

#  def two_factor_auth?
#    !self.phone.blank?
#  end
#
#  def generate_pin!
#    self.update_column(:pin, rand(10 ** 6)) #random 6 digit number
#  end
#
#  def send_pin_to_twilio
#    # put your own credentials here
#    account_sid = '#'
#    auth_token = '#'
#
#    # set up a client to talk to the Twilio REST API
#    client = Twilio::REST::Client.new(account_sid, auth_token)
#
#    msg = "Hi, please input the pin to continue login: #{ self.pin }"
#
#    client.account.messages.create({
#      :from => '#',
#      :to => '#',
#      :body => msg
#    })
#  end
#
#  def remove_pin!
#    self.update_column(:pin, nil)
#  end

  def admin?
    self.role == 'admin'
  end
end

