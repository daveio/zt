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
         'Fetch and save the current state of your networks'
    def pull
      true
    end

    desc 'auth [TOKEN]',
         'Store an authentication token (unencrypted) in the config'
    def auth(token)
      token
    end
  end
end
