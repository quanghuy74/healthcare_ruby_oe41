class License < ApplicationRecord
  belongs_to :major
  belongs_to :account
end
