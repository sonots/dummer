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
  labeled false
  field :time, type: :datetime, format: "[%Y-%m-%d %H:%M:%S]"
  field :level, type: :string, any: %w[DEBUG INFO WARN ERROR]
  field :method, type: :string, any: %w[GET POST PUT]
  field :uri, type: :string, any: %w[/api/v1/people /api/v1/textdata /api/v1/messages]
  field :reqtime, type: :float, range: 0.1..5.0
  field :foobar, type: :string, length: 8
end 
```

Running dummy_data_generator outputs like

```
[1984-05-25 05:10:03]   DEBUG   GET     /api/v1/people  4.451362369925074       fl8nmh4f
[2027-11-04 02:58:01]   INFO    GET     /api/v1/people  3.984084722909503       WhsvwEeF
[1973-02-17 09:09:34]   WARN    GET     /api/v1/people  2.290704255755689       3UyK3jgi
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

* :string

  * :any

    You can specify an array of strings, then the generator picks one from them randomly

  * :length

    You can specify the length of string to generate randomly

* :integer

  * :range

    You can specify a range of integers, then the generator picks one in the range (uniform) randomly

* :float

  * :range

    You can specify a range of integers, then the generator picks one in the range (uniform) randomly

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licenses

See [LICENSE.txt](LICENSE.txt)

