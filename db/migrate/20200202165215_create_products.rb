class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, index:true
      t.string :productFamily
      t.json :p_attributes, default: '{}'
      t.references :pricing_service 
      t.timestamps
    end
  end
end
