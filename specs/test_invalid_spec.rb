require_relative './spec_helper'

describe 'Test find station route with invalid lat and lng' do
  it 'should return invalid with no lat and lng' do
    get '/v1/ubike-station/taipei'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with no lat' do
    get '/v1/ubike-station/taipei?lng=121.49'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with no lng' do
    get '/v1/ubike-station/taipei?lat=24.8'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with invalid lat' do
    get '/v1/ubike-station/taipei?lat=91&lng=121.49'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with invalid lng' do
    get '/v1/ubike-station/taipei?lat=24.8&lng=182'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with invalid lat' do
    get '/v1/ubike-station/taipei?lat=-91&lng=121.49'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end

  it 'should return invalid with invalid lng' do
    get '/v1/ubike-station/taipei?lat=24.8&lng=-182'

    _(last_response.status).must_equal 200
    result = JSON.parse(last_response.body)
    result['code'].must_equal (-1)
    result['result'].must_equal []
  end
end
