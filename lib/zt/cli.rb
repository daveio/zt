# frozen_string_literal: true

require 'thor'
require 'zt/conf'
require 'zt/errors'
require 'zt/version'

module Zt
  # Base CLI class
  class CLI < Thor
    @config = Zt::Conf.instance
    desc 'version', 'Show the zt version number'
    def version
      puts "zt version #{Zt::VERSION}"
    end
  end
end
