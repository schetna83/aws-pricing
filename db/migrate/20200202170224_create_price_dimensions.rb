class CreatePriceDimensions < ActiveRecord::Migration[6.0]
  def change
    create_table :price_dimensions do |t|
      t.string :rateCode
      t.text :description
      t.string :beginRange
      t.string :endRange
      t.json :pricePerUnit
      t.string :unit
      t.text :appliesTo, array: true, default: []
      t.references :on_demand
      t.timestamps
    end
  end
end
