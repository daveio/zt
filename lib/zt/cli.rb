# frozen_string_literal: true

require 'thor'
require 'zt/conf'
require 'zt/constants'
require 'zt/errors'
require 'zt/version'

module Zt
  # Base CLI class
  class CLI < Thor
    attr_accessor :conf

    def initialize(thor_args = [], thor_options = {}, thor_config = {})
      super(thor_args, thor_options, thor_config)
      @conf = Conf.instance.conf
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
      token_regex = Constants::AUTH_TOKEN_REGEX
      if token.length != Constants::AUTH_TOKEN_LENGTH
        abort('Authentication token must be exactly 32 characters')
      elsif !token_regex.match?(token)
        abort('Authentication token contains invalid characters, only ' \
              'alphanumerics are permitted.')
      else
        conf.zt['token'] = token
        Zt::Conf.instance.save! :zt
      end
    end
  end
end
