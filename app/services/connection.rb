# require 'faraday'
# require 'json'

class Connection

  def self.api(url)
    Faraday.new(url: url) do |faraday|
      faraday.response :logger
      faraday.adapter Faraday.default_adapter
      faraday.headers['Content-Type'] = 'application/json'
    end
  end
end

# BASE = 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonCloudFront/current/index.json'
# api = Connection.api BASE
# res = api.get
# data = JSON.parse(res.body)
# res.status
