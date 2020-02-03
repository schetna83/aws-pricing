class PricingService < ApplicationRecord
  has_many :products, autosave: true, dependent: :destroy
  
  validates :offerCode, presence: true, uniqueness: true
  validates :publicationDate, presence: true, uniqueness: true
  validates :region, presence: true, uniqueness: true

  REGION = "us-east-1"
  SERVICE = "AmazonCloudFront"

  def self.fetch_and_save_data
    url = PricingService.get_url
    data = PricingService.parse(PricingService.fetch_data(url))
    PricingService.save_pricing_data(data)
  end

  def self.save_pricing_data(data)
    return if PricingService.find_by(publicationDate: data["publicationDate"]).present?
    PricingService.transaction do
      pricing_service = PricingService.includes(products: [on_demand: :price_dimensions]).find_or_initialize_by(offerCode: data["offerCode"], version: data["version"], publicationDate: data["publicationDate"], region: REGION)
      # pricing_service = PricingService.new(offerCode: data["offerCode"], version: data["version"], publicationDate: data["publicationDate"], region: REGION)
      data["products"].each do |product_key, product_value|
        product = pricing_service.products.find_by(sku: product_value["sku"]) ||
                  pricing_service.products.build({sku: product_value["sku"],
                              productFamily: product_value["productFamily"],
                              p_attributes: product_value["attributes"]})

        data["terms"]["OnDemand"][product_key].each do |ondemand_key,ondemand_val|
          if product.on_demand.present? && product.on_demand.offerTermCode == ondemand_val["offerTermCode"]
            p_o_d = product.on_demand
          else
            p_o_d = product.build_on_demand(offerTermCode: ondemand_val["offerTermCode"],
              effectiveDate: ondemand_val["effectiveDate"],
              termAttributes: ondemand_val["termAttributes"])
          end
          ondemand_val["priceDimensions"].each do |pd_key,pd_val|
            if p_o_d.price_dimensions.find_by(rateCode: pd_val["rateCode"]).nil?
              p_o_d.price_dimensions.build({rateCode: pd_val["rateCode"],
                                            description: pd_val["description"],
                                            beginRange: pd_val["beginRange"],
                                            endRange: pd_val["endRange"],
                                            pricePerUnit: pd_val["pricePerUnit"],
                                            unit: pd_val["unit"],
                                            appliesTo: pd_val["appliesTo"]})
            end
          end
        end
      end
      pricing_service.save!
    end
  end

  def self.parse(res)
    if res.status != 200
      raise "Error in response"
    end
    data = JSON.parse(res.body)
    data
  end

  def self.fetch_data(url)
    begin
      api = Connection.api url
      res = api.get
    rescue Exception => e
      print e
    end
  end

  def self.get_url()
    serive_url = "https://pricing.#{REGION}.amazonaws.com/offers/v1.0/aws/#{SERVICE}/current/index.json"
    serive_url
  end
end
