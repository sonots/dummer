# Dummer

#### NOTE: `dummy_log_generator` was renamed to `dummer` which is easier to type, yay!

Dummer is a set of tools to generate dummy log data for Fluentd benchmark. 

This gem includes three executable commands

1. dummer
2. dummer\_simple
3. dummer\_yes

## Installation

Add this line to your application's Gemfile:

    gem 'dummer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dummer

Run as

    $ dummer -c dummer.conf
    $ dummer_simple [options]
    $ dummer_yes [options]

## dummer

`dummer` allows you to

1. specify a rate of generating messages per second, 
2. determine a log format, and
3. generate logs randomly

### Usage

Create a configuration file. A sample configuration is as follows:

```ruby
# dummer.conf
configure 'sample' do
  output "dummy.log"
  rate 500
  delimiter "\t"
  labeled true
  field :id, type: :integer, countup: true, format: "%04d"
  field :time, type: :datetime, format: "[%Y-%m-%d %H:%M:%S]", random: false
  field :level, type: :string, any: %w[DEBUG INFO WARN ERROR]
  field :method, type: :string, any: %w[GET POST PUT]
  field :uri, type: :string, any: %w[/api/v1/people /api/v1/textdata /api/v1/messages]
  field :reqtime, type: :float, range: 0.1..5.0
  field :foobar, type: :string, length: 8
end 
```

Running

```
$ dummer -c dummer.conf
```

Outputs to the `dummy.log` (specified by `output` parameter) file like: 

```
id:0422  time:[2013-11-19 02:34:58]  level:INFO  method:POST uri:/api/v1/textdata  reqtime:3.9726677258569842  foobar:LFK6XV1N
id:0423  time:[2013-11-19 02:34:58]  level:DEBUG method:GET  uri:/api/v1/people    reqtime:0.49912949125272277 foobar:DcOYrONH
id:0424  time:[2013-11-19 02:34:58]  level:WARN  method:POST uri:/api/v1/textdata  reqtime:2.930590441869852   foobar:XEZ5bQsh
```

### CLI Options

```
$ dummer help start
Usage:
  dummer start

Options:
  -c, [--config=CONFIG]            # Config file
                                   # Default: dummer.conf
  -r, [--rate=N]                   # Number of generating messages per second
  -o, [--output=OUTPUT]            # Output file
  -m, [--message=MESSAGE]          # Output message
  -d, [--daemonize]                # Daemonize. Stop with `dummer stop`
  -w, [--workers=N]                # Number of parallels
      [--worker-type=WORKER_TYPE]
                                   # Default: process
  -p, [--pid-path=PID_PATH]
                                   # Default: dummer.pid
```

### Configuration Parameters

Following parameters in the configuration file are available:

* output

    Specify a filename to output, or IO object (STDOUT, STDERR)

* rate

    Specify how many messages to generate per second. Default: 500 msgs / sec

* workers

    Specify number of processes for parallel processing. 

* delimiter

    Specify the delimiter between each field. Default: "\t" (Tab)

* labeled

    Whether add field name as a label or not. Default: true

* field

    Define data fields to generate. `message` and `input` options are ignored. 

* input

    Use this if you want to write messages by reading lines of an input file in rotation. `message` is ignored.

* message

    Use this if you want to write only a specific message. 

### Field Data Types

You can specify following data types to your `field` parameters:

* :datetime

  * :format

    You can specify format of datetime as `%Y-%m-%d %H:%M:%S`. See [Time#strftime](http://www.ruby-doc.org/core-2.0.0/Time.html#method-i-strftime) for details. 

  * :random

    Generate datetime randomly. Default: false (Time.now)

  * :value

    You can specify a fixed Time object. 

* :string

  * :any

    You can specify an array of strings, then the generator picks one from them randomly

  * :length

    You can specify the length of string to generate randomly

  * :value

    You can specify a fixed string

* :integer

  * :format

    You can specify a format of string  as `%03d`. 

  * :range

    You can specify a range of integers, then the generator picks one in the range (uniform) randomly

  * :countup

    Generate countup data. Default: false

  * :value

    You can specify a fixed integer

* :float

  * :format

    You can specify a format of string  as `%03.1f`. 

  * :range

    You can specify a range of float numbers, then the generator picks one in the range (uniform) randomly

  * :value

    You can specify a fixed float number

## dummer\_simple

I created a simple version of `dummer` since it can not achieve the maximum system I/O throughputs because of its rich features.
This simple version, `dummer_simple` could  achieve the system I/O limit in my environment. 

### Usage

```
$ dummer_simple [options]
```

### Options

```
Usage:
  dummer_simple

Options:
      [--sync]             # Set `IO#sync=true`
  -s, [--second=N]         # Duration of running in second
                           # Default: 1
  -p, [--parallel=N]       # Number of processes to run in parallel
                           # Default: 1
  -o, [--output=OUTPUT]    # Output file
                           # Default: dummy.log
  -i, [--input=INPUT]      # Input file (Output messages by reading lines of the file in rotation)
  -m, [--message=MESSAGE]  # Output message
                           # Default: time:2013-11-20 23:39:42 +0900    level:ERROR     method:POST     uri:/api/v1/people      reqtime:3.1983877060667103
```

## dummer\_yes

I created a wrapped version of `yes` command, `dummer_yes`, to confrim that `dummer_simple` achieves the maximum system I/O throughputs. 
I do not use `dummer_yes` command anymore because I verified that `dummer_simple` achieves the I/O limit, but I will keep this command so that users can do verification experiments with it. 

### Usage

```
$ dummer_yes [options]
```

### Options

```
Usage:
  dummer_yes

Options:
  -s, [--second=N]         # Duration of running in second
                           # Default: 1
  -p, [--parallel=N]       # Number of processes to run in parallel
                           # Default: 1
  -o, [--output=OUTPUT]    # Output file
                           # Default: dummy.log
  -m, [--message=MESSAGE]  # Output message
                           # Default: time:2013-11-20 23:39:42 +0900  level:ERROR method:POST uri:/api/v1/people  reqtime:3.1983877060667103
```

## Relatives

There is a [fluent-plugin-dummydata-producer](https://github.com/tagomoris/fluent-plugin-dummydata-producer), but I wanted to output dummy data to a log file, and I wanted a standalone tool.

## Related Articles

* [Fluentd のベンチマークテストに使える dummer (旧称 dummy_log_generator)](http://qiita.com/sonots/items/750da77a18e62852a02f)

## ToDO

1. write tests
2. Add an option to send data to fluentd directly

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Licenses

See [LICENSE.txt](LICENSE.txt)

