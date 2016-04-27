require 'thor'
require 'skel'
require 'skel/helper'

module Skel # :nodoc:
  # Thor instance for CLI
  class Blah < Thor
    include Skel::Helper

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
                  desc: 'option 1 for example command, default: false',
                  type: :boolean

    method_option :opt2,
                  desc: 'option 2 for example command'

    def example(*args)
      exec_cmd('example', args, options)
    end
  end
end
