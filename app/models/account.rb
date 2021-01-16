class Account < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_one :license, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy
  has_many :rated_reviews, class_name: Review.name,
    foreign_key: :reviewer_id, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_CARDID_REGEX = /[0-9]{9}/.freeze
  VALID_PHONENUMBER_REGEX = /[0-9]{10}/.freeze

  before_save :downcase_email
  has_secure_password

  validates :email, presence: true,
    length: {maximum: Settings.account.email.max_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :full_name, presence: true
  validates :password, presence: true,
    length: {minimum: Settings.account.password.min_length}
  validates :card_id, uniqueness: true, format: {with: VALID_CARDID_REGEX}
  validates :phone_number, uniqueness: true,
    format: {with: VALID_PHONENUMBER_REGEX}
  validates :address, presence: true
  validates :role, presence: true
  validates :status, presence: true

  enum role: {
    customer: 0,
    admin: 1,
    staff: 2
  }
  enum gender: {
    male: 0,
    female: 1
  }
  enum status: {
    block: 0,
    unactive: 1,
    active: 2
  }

  private

  def downcase_email
    email.downcase!
  end
end
