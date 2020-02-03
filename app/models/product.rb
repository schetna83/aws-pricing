class Product < ApplicationRecord
  belongs_to :pricing_service
  has_one :on_demand, autosave: true, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
  validates :productFamily, presence: true, uniqueness: true

end
