require 'rails_helper'

RSpec.describe Product, type: :model do

  it "product is invalid" do
    expect(Product.new.valid?).to be_falsey
  end

  it "product is valid if it has sku and productFamily" do
    price_service = PricingService.new(offerCode: "AmazonCloudFront", publicationDate:Date.today, region: "us-east-1")
    product = price_service.products.build(sku: "djksjsk", productFamily: "EC2")
    expect(product.valid?).to be_truthy
  end

end
