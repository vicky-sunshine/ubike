require_relative './spec_helper'

describe 'Test find station route with all full stations' do
  before do
    Station.dataset.delete
    CreateStations.import(seed_file: 'sample_stations.json')
  end
  it 'should return nearest station' do
    get "/v1/ubike-station/taipei?lat=25.034153&lng=121.568509"

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal 0
    result['result'].count.must_equal 2
    result['result'].first['station'].must_equal "世貿二館"
    result['result'].first['num_ubike'].must_be :>, 0
    result['result'].last['station'].must_equal "世貿三館"
    result['result'].first['num_ubike'].must_be :>, 0
  end
end
