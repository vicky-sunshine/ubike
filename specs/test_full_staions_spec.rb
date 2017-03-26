require_relative './spec_helper'

describe 'Test find station route with all full stations' do
  before do
    Station.dataset.delete
    CreateStations.import(seed_file: 'all_full_stations.json')
  end
  it 'should return full station' do
    get "/v1/ubike-station/taipei?lat=25.034153&lng=121.568509"

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal 1
    result['result'].must_equal []
  end
end
