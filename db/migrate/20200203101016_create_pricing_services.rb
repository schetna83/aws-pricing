class CreatePricingServices < ActiveRecord::Migration[6.0]
  def change
    create_table :pricing_services do |t|
      t.string :offerCode
      t.string :version
      t.timestamp :publicationDate
      t.string :region
      t.timestamps
    end
  end
end
