# Youbike [![Build Status](https://travis-ci.org/vicky-sunshine/youbike.svg?branch=master)](https://travis-ci.org/vicky-sunshine/youbike)


## API using example

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
