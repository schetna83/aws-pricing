class PriceDimension < ApplicationRecord
  belongs_to :on_demand
  validates :rateCode, presence: true, uniqueness: true

end
