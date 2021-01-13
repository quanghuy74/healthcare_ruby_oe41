class Major < ApplicationRecord
  has_many :licenses, dependent: :destroy
  has_many :services, dependent: :destroy
end
