require 'rails_helper'

RSpec.describe PricingService, type: :model do

  it "pricing_service is invalid" do
    expect(PricingService.new.valid?).to be_falsey
  end

  it "pricing_service is valid if it has offerCode, publicationDate and region" do
    pricing_service = PricingService.new(offerCode: "AmazonCloudFront", publicationDate:Date.today, region: "us-east-1")
    expect(pricing_service.valid?).to be_truthy
  end

end
