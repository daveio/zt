# frozen_string_literal: true

require 'thor'
require 'zt/conf'
require 'zt/errors'
require 'zt/version'

module Zt
  # Base CLI class
  class CLI < Thor
    attr_accessor :conf

    def initialize(thor_args = [], thor_options = {}, thor_config = {})
      super(thor_args, thor_options, thor_config)
      @conf = Zt::Conf.instance.conf
    end

    desc 'version', 'Show the zt version number'
    def version
      puts "zt version #{Zt::VERSION}"
    end

    desc 'pull',
         'Show the internal representation of the loaded config'
    def debug_conf
      puts conf.to_s
    end
  end
end
