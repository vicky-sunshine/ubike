require_relative './spec_helper'

describe 'Test find station route with not in taipei location' do
  it 'should return not in taipei' do
    lat = random_not_in_taipei_lat
    lng = random_not_in_taipei_lng
    get "/v1/ubike-station/taipei?lat=#{lat}&lng=#{lng}"

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-2)
    result['result'].must_equal []
  end
end
