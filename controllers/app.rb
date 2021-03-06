require 'sinatra'
require 'json'

class YoubikeAPI < Sinatra::Base
  enable :logging

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and
                          @auth.credentials and
                          @auth.credentials == [ENV['ACCOUNT'], ENV['PASSWORD']]
    end

    def lat_is_invalid?(lat)
      lat.nil? || lat.to_f.abs > 90
    end

    def lng_is_invalid?(lng)
      lng.nil? || lng.to_f.abs > 180
    end
  end

  get '/' do
    'Hello, This is Ubike API running. Current API version is v1.'
  end

  post '/v1/update' do
    protected!
    begin
      data = JSON.parse(request.body.read)
      stations = data['records']
      stations.each do |e|
        s = Station.by_sno(e['sno'])
        if s.nil?
          s = Station.new(e)
          s.save
        else
          UpdateStation.call(
            sno: e['sno'],
            sbi: e['sbi'].to_i,
            mday: e['mday'],
            bemp: e['bemp'].to_i,
            act: e['act'].to_i
          )
        end
      end
    rescue => e
      halt 400, JSON.pretty_generate({"error": e.to_s})
    end
    status 202
  end

  get '/v1/ubike-station/taipei' do
    # ?lat=25.034153&lng=121.568509
    lat = params['lat']
    lng = params['lng']

    begin
      # check lat lng valid
      if lat_is_invalid?(lat) || lng_is_invalid?(lng)
        return JSON.pretty_generate({ "code": -1,  "result": []})
      end

      # check raw location in taipei
      if !GoogleApi.in_taipei_city?(lat: lat, lng:lng)
        return JSON.pretty_generate({ "code": -2,  "result": []})
      end

      if Station.full.count == Station.available.count
        return JSON.pretty_generate({ "code": 1,  "result": []})
      end

      stations = Station.available.not_empty.by_distance(lat,lng).limit(2)
      JSON.pretty_generate({
        "code": 0,
        "result": stations.map {|n| n}
      })
    rescue => e
      logger.info "FAILED to find nearest ubike stations: #{e.inspect}"
      JSON.pretty_generate({ "code": -3,  "result": []})
    end
  end

end
