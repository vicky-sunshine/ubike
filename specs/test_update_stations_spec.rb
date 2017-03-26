require 'base64'
require_relative './spec_helper'

describe 'Test update station' do
  before do
    Station.dataset.delete
    CreateStations.import(seed_file: 'sample_stations.json')
  end

  it 'should update successfully' do
    token = Base64.encode64("#{ENV['ACCOUNT']}:#{ENV['PASSWORD']}")
    req_header = {
      'CONTENT_TYPE' => 'application/json',
      'HTTP_AUTHORIZATION' => "Basic #{token}"
    }
    req_body = {
      records:[{
      	sno: "0001",
      	sbi: 120,
      	mday: "20170326204426",
      	bemp: 30,
      	act: 1}]
      }.to_json

    post_update_url = "/v1/update"
    post post_update_url, req_body, req_header

    _(last_response.status).must_equal 202
    s = Station.by_sno("0001")
    s.sbi.must_equal 120
    s.bemp.must_equal 30
    s.act.must_equal 1
  end

  it 'should update successfully' do
    token = Base64.encode64("#{ENV['ACCOUNT']}:#{ENV['PASSWORD']}")
    req_header = {
      'CONTENT_TYPE' => 'application/json',
      'HTTP_AUTHORIZATION' => "Basic #{token}"
    }
    req_body = {
      records:[{
        sno: "0001",
        sbi: 120,
        mday: "20170326204426",
        bemp: 30,
        act: 1}]
      }.to_json

    post_update_url = "/v1/update"
    post post_update_url, req_body, req_header

    _(last_response.status).must_equal 202
    Station.count.must_equal 10
    s = Station.by_sno("0001")
    s.sbi.must_equal 120
    s.bemp.must_equal 30
    s.act.must_equal 1
  end

  it 'should update and create successfully' do
    token = Base64.encode64("#{ENV['ACCOUNT']}:#{ENV['PASSWORD']}")
    req_header = {
      'CONTENT_TYPE' => 'application/json',
      'HTTP_AUTHORIZATION' => "Basic #{token}"
    }
    req_body = {
      records:[{
          "sno": "0010",
          "sna": "台北市災害應變中心",
          "tot": "54",
          "sbi": "0",
          "sarea": "信義區",
          "mday": "20170325204423",
          "lat": "25.0286611111",
          "lng": "121.566116667",
          "ar": "台北市信義區莊敬路391巷11弄2號",
          "sareaen": "Xinyi Dist.",
          "snaen": "Emergency Operations Center of Taipei City",
          "aren": "No.2, Aly. 11, Ln. 391, Zhuangjing Rd.",
          "bemp": "0",
          "act": "0"},
        {
          "sno": "0011",
          "sna": "三張犁",
          "tot": "66",
          "sbi": "24",
          "sarea": "信義區",
          "mday": "20170325204440",
          "lat": "25.034937",
          "lng": "121.55762",
          "ar": "光復南路\/基隆路一段364巷",
          "sareaen": "Xinyi Dist.",
          "snaen": "Sanchangli",
          "aren": "The S.E. side of Road Guangfu South & Ln. 346, Sec. 1, Keelung Rd.",
          "bemp": "42",
          "act": "1"
        }]
      }.to_json

    post_update_url = "/v1/update"
    post post_update_url, req_body, req_header

    _(last_response.status).must_equal 202
    s = Station.by_sno("0010")
    s.sbi.must_equal 0
    s.bemp.must_equal 0
    s.act.must_equal 0

    Station.count.must_equal 11
    s = Station.by_sno("0011")
    s.sbi.must_equal 24
    s.bemp.must_equal 42
    s.act.must_equal 1
  end

end
