# DummyDataGenerator

Generates dummy log data.

## Installation

Add this line to your application's Gemfile:

    gem 'dummy_data_generator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dummy_data_generator

Run as

    $ dummy_data_generator -c dummy_data_generator.conf

## Usage

Sample configuration is as follows:

```ruby
# dummy_data_generator.conf
configure 'sample' do
  rate 500
  delimiter "\t"
  labeled true
  params :time => :datetime,
         :level => %w[DEBUG INFO WARN ERROR],
         :method => %w[GET POST PUT],
         :uri => %w[/api/v1/people /api/v1/textdata /api/v1/messages],
         :reqtime => 0.1..5.0
end 
```

Running dummy_data_generator outputs like

```
time:2031-06-18 18:18:00        level:INFO      method:POST     uri:/api/v1/people      reqtime:1.197221723342187
time:1996-05-09 18:37:00        level:INFO      method:POST     uri:/api/v1/people      reqtime:3.271667783792904
time:1987-07-09 06:58:00        level:WARN      method:POST     uri:/api/v1/textdata    reqtime:3.1576537349315683
time:1995-07-11 19:45:00        level:DEBUG     method:POST     uri:/api/v1/textdata    reqtime:3.6156928236603902
time:2017-08-09 04:49:00        level:DEBUG     method:GET      uri:/api/v1/people      reqtime:4.262477727171734
```

## Configuration Parameters

Following parameters for configuration is available

* rate

    Specify how many messages to generate per second. Default: 500 msgs / sec

* delimiter

    Specify the delimiter between each columns. Default: tab

* labeled

    Add label or not. Default: true

* params

    This is the main format of your data

## Data Types

You can specify following data types to your `params` parameters:

* :datetime

* :string

* :integer

* Array

  Pick one from the given array (uniform) randomly

* Range

  Pick one from the given range (uniform) randomly

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licenses

See [LICENSE.txt](LICENSE.txt)

