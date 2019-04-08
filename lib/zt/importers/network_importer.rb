# frozen_string_literal: true

require 'zt/conf'
require 'zt/importers/_base_importer'

module Zt
  module Importers
    class NetworkImporter < BaseImporter
      def import
        output = {}
        # normalise data
        normalised_networks = networks.map do |n|
          {
            network_id: n['id'],
            network_name: n['config']['name'],
            network_description: n['description'],
            network_total_members: n['totalMemberCount'],
            network_authorized_members: n['authorizedMemberCount'],
            network_pending_members:
              (n['totalMemberCount'] - n['authorizedMemberCount'])
          }
        end
        domains_conf = Zt::Conf.instance.conf.domains
        normalised_networks.each do |n|
          zone = if domains_conf.key? n[:network_id]
                   if n[:network_id].empty?
                     qualify(n[:network_id])
                   else
                     qualify(domains_conf[n[:network_id]])
                   end
                 else
                   qualify(n[:network_name])
                 end
          output[n[:network_id]] = {} unless output.key?(n[:network_id])
          output[n[:network_id]][:remote] = n
          output[n[:network_id]][:local] = {
            dns_zone: zone
          }
        end
        output
      end
    end
  end
end
