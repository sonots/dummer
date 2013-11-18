require 'yaml'
require 'thor'
require 'dummy_data_logger'
require 'active_support/core_ext'

module DummyDataLogger
  class CLI < Thor
    class_option :config, :aliases => ["-c"], :type => :string, :default => 'dummy_data_logger.conf'
    default_command :start

    def initialize(args = [], opts = [], config = {})
      super(args, opts, config)

      if options[:config] && File.exists?(options[:config])
        config = instance_eval(File.read(options[:config]), options[:config])
        @options = config.merge(@options)
      end
    end

    desc "start", "Start a dummy_data_logger"
    option :require,     :aliases => ["-r"], :type => :string
    option :daemonize,   :aliases => ["-d"], :type => :boolean
    option :interval,    :aliases => ["-i"], :type => :numeric
    option :module_name, :aliases => ["-m"], :type => :string, :default => 'DummyDataLogger::Worker'
    # options for dummy_data_logger
    option :logdev,      :aliases => ["-l"], :type => :string,  :default => 'dummy.log'
    option :shift_age,   :aliases => ["-a"], :type => :numeric, :default => 0
    option :shit_size,   :aliases => ["-s"], :type => :numeric, :shift_size => 1048576
    def start
      opts = @options.symbolize_keys.except(:require, :config, :interval, :module_name)

      se = ServerEngine.create(nil, @options["module_name"].constantize, opts)
      se.run
    end

    desc "stop", "Stops a dummy_data_logger"
    option :pid_path,    :aliases => ["-p"], :type => :string
    def stop
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("QUIT", pid)
        puts "Stopped #{pid}"
      rescue Errno::ESRCH
        puts "DummyDataLogger #{pid} not running"
      end
    end

    desc "graceful_stop", "Gracefully stops a dummy_data_logger"
    option :pid_path,    :aliases => ["-p"], :type => :string
    def graceful_stop
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("TERM", pid)
        puts "Gracefully stopped #{pid}"
      rescue Errno::ESRCH
        puts "DummyDataLogger #{pid} not running"
      end
    end

    desc "restart", "Restarts a dummy_data_logger"
    option :pid_path,    :aliases => ["-p"], :type => :string
    def restart
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("HUP", pid)
        puts "Restarted #{pid}"
      rescue Errno::ESRCH
        puts "DummyDataLogger #{pid} not running"
      end
    end

    desc "graceful_restart", "Graceful restarts a dummy_data_logger"
    option :pid_path,    :aliases => ["-p"], :type => :string
    def graceful_restart
      pid = File.read(@options["pid_path"]).to_i

      begin
        Process.kill("USR1", pid)
        puts "Gracefully restarted #{pid}"
      rescue Errno::ESRCH
        puts "DummyDataLogger #{pid} not running"
      end
    end

  end
end

DummyDataLogger::CLI.start(ARGV)
