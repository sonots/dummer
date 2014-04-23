require 'thor'
require 'dummer'
require 'ext/hash/keys'
require 'ext/hash/except'

module Dummer
  class CLI < Thor
    # options for serverengine
    class_option :pid_path, :aliases => ["-p"], :type => :string, :default => 'dummer.pid'
    default_command :start

    def initialize(args = [], opts = [], config = {})
      super(args, opts, config)
    end

    desc "start", "Start a dummer"
    option :config,    :aliases => ["-c"], :type => :string, :default => 'dummer.conf', :desc => 'Config file'
    option :rate,      :aliases => ["-r"], :type => :numeric, :desc => 'Number of generating messages per second'
    option :output,    :aliases => ["-o"], :type => :string, :desc => 'Output file'
    option :host,      :aliases => ["-h"], :type => :string, :desc => 'Host of fluentd process'
    option :port,      :aliases => ["-p"], :type => :numeric, :desc => 'Port of fluentd process'
    option :message,   :aliases => ["-m"], :type => :string, :desc => 'Output message'
    # options for serverengine
    option :daemonize, :aliases => ["-d"], :type => :boolean, :desc => 'Daemonize. Stop with `dummer stop`'
    option :workers,   :aliases => ["-w"], :type => :numeric, :desc => 'Number of parallels'
    option :log,       :aliases => ["-l"], :type => :string, :desc => 'Dummer Log File'
    option :worker_type,                   :type => :string, :default => 'process'
    def start
      @options = @options.dup # avoid frozen
      dsl =
        if options[:config] && File.exists?(options[:config])
          instance_eval(File.read(options[:config]), options[:config])
        else
          Dummer::Dsl.new
        end
      dsl.setting.rate = options[:rate] if options[:rate]
      dsl.setting.output = options[:output] if options[:output]
      dsl.setting.host = options[:host] if options[:host]
      dsl.setting.port = options[:port] if options[:port]
      dsl.setting.message = options[:message] if options[:message]
      @options[:setting] = dsl.setting
      # options for serverengine
      @options[:workers] ||= dsl.setting.workers
      @options[:log] ||= dsl.setting.log

      opts = @options.symbolize_keys.except(:config)
      se = ServerEngine.create(nil, Dummer::Worker, opts)
      se.run
    end

    desc "stop", "Stops a dummer"
    def stop
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("QUIT", pid)
        puts "Stopped #{pid}"
      rescue Errno::ESRCH
        puts "Dummer #{pid} not running"
      end
    end

    desc "graceful_stop", "Gracefully stops a dummer"
    def graceful_stop
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("TERM", pid)
        puts "Gracefully stopped #{pid}"
      rescue Errno::ESRCH
        puts "Dummer #{pid} not running"
      end
    end

    desc "restart", "Restarts a dummer"
    def restart
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("HUP", pid)
        puts "Restarted #{pid}"
      rescue Errno::ESRCH
        puts "Dummer #{pid} not running"
      end
    end

    desc "graceful_restart", "Graceful restarts a dummer"
    def graceful_restart
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("USR1", pid)
        puts "Gracefully restarted #{pid}"
      rescue Errno::ESRCH
        puts "Dummer #{pid} not running"
      end
    end

  end
end

Dummer::CLI.start(ARGV)
