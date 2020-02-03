class PricingServiceController < ApplicationController
  def index
    date = params[:date].present? ?  params[:date] : OnDemand.get_max_date
    # ps = PricingService.find_by(region: params[:region],offerCode:params[:offerCode])
    # products = ps.products.includes(on_demand: :price_dimensions).where(on_demands: {effectiveDate: date})
    pricing_service = PricingService.includes(products: [on_demand: :price_dimensions]).where(region: params[:region],offerCode:params[:offerCode],on_demands: {effectiveDate: date}).first
    output = []
    pricing_service.products.each do |p|
      data = {}
      data["effectiveDate"] = p.on_demand.effectiveDate
      p.on_demand.price_dimensions.each do |p_d|
        data["description"] = p_d.description
        data["beginRange"] = p_d.beginRange
        data["endRange"] = p_d.endRange
        data["unit"] = p_d.unit
        data["pricePerUnit"] = p_d.pricePerUnit["USD"]
      end
      output<<data
    end
    render json: {output:output}
  end
end
