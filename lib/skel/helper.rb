require 'thor'
require 'erb'
require 'skel'

module Skel # :nodoc

  module Helper # :nodoc

    # @param task: name of task , this is cli command option
    # @param args: this is first argument passed to thor command without hyphen in front
    # @param additional_options: these are additional options passed with hyphen
    # @return Return value will be call() defined for each command.
    def exec_cmd(task, args, options)
      opt = options.dup.inject({}) { |o, (k, v)| o[k.to_sym] = v; o }
      options = @config.merge(additional_options)
      @config[:verbose] = opt.fetch(:verbose) { Skel.verbose? }
      Skel.logger = Skel.default_logger(@config[:verbose])
      options = @config.merge(opt)
      require "skel/command/#{task}"
      str_const = Thor::Util.camel_case(task)
      klass = ::Skel::Command.const_get(str_const)
      klass.new(task, args, options).call
    end

    class Template
      include ERB::Util
      attr_accessor :data, :template
      def initialize(data, template)
        @data = data
        @template = template
      end

      def render
        ERB.new(@template).result(binding)
      end

      def save(file)
        File.open(file, 'w+') { |f| f.write(render) }
      end
    end


  end

end