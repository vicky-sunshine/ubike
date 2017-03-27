# Youbike API Server [![Build Status](https://travis-ci.org/vicky-sunshine/ubike.svg?branch=master)](https://travis-ci.org/vicky-sunshine/ubike)

To find 2 nearest ubike stationns by given latitude and longitude in request parameters.

## API using example
### Get nearest stations route
**GET /v1/ubike-station/taipei?lat={lat}&lng={lng}**
- Get 2 nearest stations
- When error/exceptions occurs, it will return `None-Zero` code and a empty list as result. These `None-Zero` code implies:
  - `1` : all ubike stations are full
  - `0` : OK
  - `-1`: invalid latitude or longitude
  - `-2`: given location not in Taipei City
  - `-3`: system error

Example 1:
```shell
$ curl http://localhost:9292/v1/ubike-station/taipei\?lat\=25.034153\&lng\=121.568509
```
```json
{
  "code": 0,
  "result": [
    {
      "station": "興雅國中",
      "num_ubike": 24
    },
    {
      "station": "世貿二館",
      "num_ubike": 41
    }
  ]
}
```

Example 2 (error situation):
```shell
$ curl http://localhost:9292/v1/ubike-station/taipei\?lat\=24.999087\&lng\=121.327547
```
```json
{
  "code": -2,
  "result": [

  ]
}
```

### Update stations route
**POST /v1/update**
- update stations data
  - need basic authentication (username:password)
  - request body
    ```JSON
    {
	     "records":[{
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
      }
    ```
- response
  - return 202, if update successfully
  - return 401, if account and password not matched
  - return 400, if requet body format is invalid

Example:
```shell
$ curl http://localhost:9292/v1/update \
  --user {username}:{password} \
  -H 'content-type: application/json' \
  -X POST \
  -d "{\"records\":[{\"sno\":\"0010\",\"sna\":\"台北市災害應變中心\",\"tot\":\"54\",\"sbi\":\"0\",\"sarea\":\"信義區\",\"mday\":\"20170325204423\",\"lat\":\"25.0286611111\",\"lng\":\"121.566116667\",\"ar\":\"台北市信義區莊敬路391巷11弄2號\",\"sareaen\":\"XinyiDist.\",\"snaen\":\"EmergencyOperationsCenterofTaipeiCity\",\"aren\":\"No.2,Aly.11,Ln.391,ZhuangjingRd.\",\"bemp\":\"0\",\"act\":\"0\"}]}"
```

## Development
### Installation
After clone this repository, use `bundle` to install all dependences.

```sh
$ bundle install
```

Install the database.
```
$ rake db:migrate
```
If you want to add some sample data of youbike stations, you can import `db/seeds/sample_stations.json` by running
```
$ rake db:seed
```
(see sample data details in `db/seeds/sample_stations.json`)

Please copy the `config_env.rb.example` to `config_env.rb`
```
cp config/config_env.rb.example config/config_env.rb
```
Then fill the `ACCOUNT` and `PASSWORD` in `config_env.rb` envioronment variable for basic authentication.

### Run

Use `rackup` to run the web app, and visit [http://localhost:9292](http://localhost:9292/).

```sh
$ rackup
Thin web server (v1.7.0 codename Dunder Mifflin)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
```

### Testing

```sh
$ RACK_ENV=test rake db:migrate # create db for test
$ rake spec
```
