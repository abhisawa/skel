require 'skel'

module Skel
  module Command
    class Example # :nodoc:
      attr_accessor :logger
      attr_accessor :config

      def initialize(task, args = [], options = {})
        config = {}
        config[:opt1] = options.fetch(:opt1) { false }
        config[:opt2] = options.fetch(:opt2) { 'Option 2 string' }
        config[:task] = task.to_s
        config[:args] = args
        config[:verbose] = options.fetch(:verbose) { Skel.is_verbose? }

        @logger = Skel.default_logger(config[:verbose])
        @config = config
      end

      def print_args
        @config[:args].each { |a| puts a }
      end

      def print_opt1
        @config[:opt1] ? (puts 'Option 1 is true') : (puts 'Option 1 is false')
      end

      def print_opt2
        puts "Option 2 is  #{@config[:opt2]}"
      end

      def log
        logger.debug('Logging this because verbositry set to true')
      end

      def call
        log
        print_args
        print_opt1
        print_opt2
        true
      end
    end
  end
end
