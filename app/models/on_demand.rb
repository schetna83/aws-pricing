class OnDemand < ApplicationRecord
  has_many :price_dimensions,autosave: true, dependent: :destroy
  validates :offerTermCode, presence: true, uniqueness: true
  validates :effectiveDate, presence: true, uniqueness: true

  def self.get_max_date
    OnDemand.maximum('effectiveDate')
  end
end
