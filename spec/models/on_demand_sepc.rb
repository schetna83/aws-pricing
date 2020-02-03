require 'rails_helper'

RSpec.describe OnDemand, type: :model do

  it "on_demand is invalid" do
    expect(OnDemand.new.valid?).to be_falsey
  end

  it "on_demand_service is valid if it has offerTermCode and publicationDate" do
    on_d = OnDemand.new(offerTermCode: "JRTCKXETXF", effectiveDate:Date.today)
    expect(on_d.valid?).to be_truthy
  end

end
