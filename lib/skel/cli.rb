require 'thor'
require 'skel'

module Skel # :nodoc:
  # Thor instance for CLI
  class CLI
    module ExecCommand # :nodoc:
      # @param task: name of task , this is cli command option
      # @param args: this is first argument passed to thor command without hyphen in front
      # @param additional_options: these are additional options passed with hyphen
      # @return Return value will be call() defined for each command.
      def exec_cmd(task, args, additional_options = {})
        options = @config.merge(additional_options)
        require "skel/command/#{task}"
        str_const = Thor::Util.camel_case(task)
        klass = ::Skel::Command.const_get(str_const)
        klass.new(task, args, options).call
      end
    end

    include ExecCommand

    # Config options of each run held by this variable
    attr_reader :config

    # hash to hold options for changing them to symbol hash
    # in option_key_to_sym!
    attr_accessor :opt

    def initialize(*args)
      super
      $stdout.sync = true
      @config = {}
    end

    # common options which required for all commands
    # this might need yamas server params in future
    def self.common_options
      method_option :verbose,
                    aliases: '-v',
                    desc: 'Turn on verbosity , default: false',
                    type: :boolean
    end

    desc 'example', 'example command'
    common_options
    method_option :opt1,
                  aliases: '-o1',
                  desc: 'option 1 for example command, default: false',
                  type: :boolean

    method_option :opt2,
                  aliases: '-o2',
                  desc: 'option 2 for example command'

    def example(*args)
      option_key_to_sym!
      update_logger!
      exec_cmd('example', args, @opt)
    end

    private

    # for some odd reason options are not getting collected in form of symbols
    # this function just convert all keys in symbols
    def option_key_to_sym!
      c = options.dup
      @opt = c.inject({}) { |o, (k, v)| o[k.to_sym] = v; o }
    end

    # update logger according to verbosity
    # default is false which get overriden by ENV['VERBOSE']
    # which can get overriden by command line param --verbose
    def update_logger!
      @config[:verbose] = @opt.fetch(:verbose) { Skel.is_verbose? }
      Skel.logger = Skel.default_logger(@config[:verbose])
    end
  end
end
