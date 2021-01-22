class License < ApplicationRecord
  belongs_to :major
  belongs_to :account

  delegate :name, to: :major, prefix: :major
end
