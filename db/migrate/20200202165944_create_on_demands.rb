class CreateOnDemands < ActiveRecord::Migration[6.0]
  def change
    create_table :on_demands do |t|
      t.string :offerTermCode
      t.timestamp :effectiveDate
      t.json :termAttributes, default: '{}'
      t.references :product
      t.timestamps
    end
  end
end
