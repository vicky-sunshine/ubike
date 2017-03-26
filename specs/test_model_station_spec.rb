require_relative './spec_helper'

describe 'Test Model Staion' do
  lat = 25.0316
  lng = 121.5744

  before do
    Station.dataset.delete
    CreateStations.import(seed_file: 'sample_stations.json')
  end

  it 'should return station available' do
    Station.available.count.must_equal 8
  end

  it 'should return station not available' do
    Station.not_available.count.must_equal 2
  end

  it 'should return station empty' do
    Station.empty.count.must_equal 2
  end

  it 'should return station not empty' do
    Station.not_empty.count.must_equal 6
  end

  it 'should return station full' do
    Station.full.count.must_equal 3
  end

  it 'should return station not full' do
    Station.not_full.count.must_equal 5
  end

  it 'should calculate the distance btw user and station' do
    lat = 25.0316
    lng = 121.5744
    Station.all.each do |s|
      d = distance(s.lat, s.lng, lat, lng)
      s.distance(lat, lng).must_equal d
    end
  end

  it 'should calculate the distance btw user and station' do
    Station.all.each do |s|
      d = distance(s.lat, s.lng, lat, lng)
      s.distance(lat, lng).must_equal d
    end
  end

  it 'should return stations ordered by distance' do
    result = ["0009", "0005", "0010", "0007", "0006", "0003", "0008", "0001", "0004", "0002"]
    Station.by_distance(lat,lng).each_with_index do |s, i|
      s.sno.must_equal result[i]
    end
  end
end
