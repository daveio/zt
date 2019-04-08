# frozen_string_literal: true

require 'zt/conf'

module Zt
  module Importers
    class BaseImporter
      attr_accessor :networks
      attr_accessor :nodes
      def initialize(networks, nodes)
        @networks = networks
        @nodes = nodes
      end

      def import
        abort('import called on non-functional superclass importer')
      end

      private

      def dnsify(input)
        zt_conf = Zt::Conf.instance.conf.zt
        tld_key = 'top_level_domains'
        tld = if zt_conf.key?(tld_key) && !zt_conf[tld_key].empty?
                zt_conf[tld_key]
              else
                'zt'
              end
        clean = input.tr('-', '_')
        clean = clean.gsub(/([\W])/, '-')
        clean = clean.tr('_', '-')
        clean = clean.gsub(/(-+)/, '-')
        clean = "network-#{clean}" unless clean.match?(/^[A-Za-z]/)
        clean = clean.gsub(Regexp.new("-#{tld}$"), '')
        clean.gsub(/(-+)/, '-')
      end

      def qualify(zone)
        zt_conf = Zt::Conf.instance.conf.zt
        "#{dnsify(zone)}.#{zt_conf['top_level_domain']}"
      end
    end
  end
end
