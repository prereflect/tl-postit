class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  before_save :generate_slug!

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = User.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\W/, '-'
    str.gsub! /_/, '-'
    str.gsub! /-+/, '-'
    str.gsub! /^-|-$/, ''
    str.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    end
    return str + '-' + count.to_s
  end
end

