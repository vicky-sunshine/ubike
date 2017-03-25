require 'http'

class GoogleApi
  def self.in_taipei_city?(lat:, lng:)
    url = "http://maps.googleapis.com/maps/api/geocode/json?latlng=#{lat},#{lng}"
    res = JSON.parse(HTTP.get(url))['results']
    return false if res.empty?

    addr = res.first['formatted_address']
    addr.include?('Taipei City')
  end
end
