# Faraday::FilterableLogger

TODO: description

## Installation

Add this line to your application's Gemfile:

```ruby
gem "faraday-filterable_logger"
```

And then execute:

```bash
$ bundle install
```

## Usage

Once required, the logger can be added to any Faraday connection by inserting
it into your connection's request/response stack:

```ruby
connection = Faraday.new(url: "http://foo.com") do |faraday|
  faraday.request  :url_encoded
  faraday.response :filterable_logger, nil, filter: fields_to_filter, log_options: { bodies: [true/false], headers: [true/false] }
end
```

By default, the Faraday::FilterableLogger will log to STDOUT. If this is not your
desired log location, simply provide any Logger-compatible object as a
parameter to the middleware definition:

```ruby
faraday.response :filterable_logger, Rails.logger, filter: fields_to_filter
```

### Example output

#### Request logging

Log output for the request-portion of an HTTP interaction:

```plain
GET http://sushi.com/temaki?api=[FILTERED]
```
