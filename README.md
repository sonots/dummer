# DummyLogGenerator

Generates dummy log data for Fluentd benchmark 

## Installation

Add this line to your application's Gemfile:

    gem 'dummy_log_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dummy_log_generator

Run as

    $ dummy_log_generator -c dummy_data_generator.conf

## Usage

Sample configuration is as follows:

```ruby
# dummy_log_generator.conf
configure 'sample' do
  rate 500
  delimiter "\t"
  labeled false
  field :id, type: :integer, countup: true
  field :time, type: :datetime, format: "[%Y-%m-%d %H:%M:%S]", random: true
  field :level, type: :string, any: %w[DEBUG INFO WARN ERROR]
  field :method, type: :string, any: %w[GET POST PUT]
  field :uri, type: :string, any: %w[/api/v1/people /api/v1/textdata /api/v1/messages]
  field :reqtime, type: :float, range: 0.1..5.0
  field :foobar, type: :string, length: 8
end 
```

Running dummy_log_generator outputs like

```
360     [2031-02-09 15:01:07]   DEBUG   GET     /api/v1/people  1.105236938958904       PcGw8kEi
361     [1991-08-26 13:03:05]   WARN    GET     /api/v1/people  1.8938518088450287      RGOuoydG
362     [2037-11-04 15:32:38]   DEBUG   POST    /api/v1/people  2.7431863060457538      rVij0nWP
```

## Configuration Parameters

Following parameters for configuration is available

* rate

    Specify how many messages to generate per second. Default: 500 msgs / sec

* delimiter

    Specify the delimiter between each columns. Default: tab

* labeled

    Add label or not. Default: true

* field

    Define data fields to generate

## Data Types

You can specify following data types to your `field` parameters:

* :datetime

  * :format

    You can specify format of datetime as `%Y-%m-%d %H:%M:%S`. See [Time#strftime](http://www.ruby-doc.org/core-2.0.0/Time.html#method-i-strftime) for details. 

  * :random

    Generate datetime randomly or not (Time.now). Default: false

* :string

  * :any

    You can specify an array of strings, then the generator picks one from them randomly

  * :length

    You can specify the length of string to generate randomly

* :integer

  * :range

    You can specify a range of integers, then the generator picks one in the range (uniform) randomly

  * :countup

    Generate countup data. Default: false

* :float

  * :range

    You can specify a range of integers, then the generator picks one in the range (uniform) randomly

## Relatives

There is a [fluent-plugin-dummydata-producer](https://github.com/tagomoris/fluent-plugin-dummydata-producer), but I wanted to output dummy data to a log file, and I wanted a standalone tool.

## ToDO

1. write tests
2. make it slim (remove active_support, etc)
3. outputs to a file (currently, outputs to STDOUT)
4. speed up (evaluate fields at only starting up)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licenses

See [LICENSE.txt](LICENSE.txt)

