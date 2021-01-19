class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :newest_first, ->{order created_at: :desc}
end
