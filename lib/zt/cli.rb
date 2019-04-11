# frozen_string_literal: true

require 'thor'
require 'zt'

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
      puts '≫ pull started'
      puts '  ≫ pulling'
      rapi = Zt::RemoteAPI::ZeroTierAPI.new
      print '    ≫ networks '
      rnetworks = rapi.networks
      column_width = rnetworks.map { |n| n['config']['name'].length }.max + 1
      print ' ' * (column_width + 9)
      puts '✅'
      rnodes = {}
      rnetworks.each do |net|
        netid = net['id']
        netname = net['config']['name']
        print "    ≫ nodes for network #{netname}"
        rnodes[netid] = rapi.network_members(netid)
        print ' ' * (column_width - netname.length)
        puts '✅'
      end
      puts '  ≫ processing'
      importer_results = Zt::Importers::Importer.new(rnetworks, rnodes).import
      lnetworks = {}
      ldomains = {}
      lnodes = {}
      importer_results.each do |importer_result|
        if importer_result.key?(:networks)
          importer_result[:networks].each_key do |netid|
            ldomains[netid] =
              importer_result[:networks][netid][:local][:dns_zone]
            lnetworks[netid] = importer_result[:networks][netid]
          end
        end

        next unless importer_result.key?(:nodes)

        importer_result[:nodes].each_key do |nodeid|
          lnodes[nodeid] = importer_result[:nodes][nodeid]
        end
      end
      puts '  ≫ saving'
      Zt::Conf.instance.conf.domains = ldomains
      Zt::Conf.instance.conf.networks = lnetworks
      Zt::Conf.instance.conf.nodes = lnodes
      Zt::Conf.instance.save!
      puts '≫ pull completed'
    end

    desc 'export',
         'export the on-disk database to STDOUT in /etc/hosts format'
    def export(format = :hosts)
      output = Zt::Exporters::Exporter.new.export_one_format :hosts
      puts output
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
