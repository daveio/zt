# frozen_string_literal: true

# Node importer output schema:
# {
#   node_id: {
#     # TODO: warn if multiple hostnames for same node id, pick the most common
#     hostname: 'hostname',
#     memberships: {
#       network_id: {
#         addrs: [
#           '1.1.1.1',
#           '2.2.2.2'
#         ]
#       },
#       another_network_id: {
#         addrs: [
#           '1.2.3.4',
#           '1.2.3.5'
#         ]
#         flags: []
#       },
#       yet_another_network_id: {
#         addrs: [
#           '1.2.3.4',
#           '1.2.3.5'
#         ]
#         flags: []
#       }
#     }
#   }
# }
require 'json'
require 'zt/importers/_base_importer'

module Zt
  module Importers
    class NodeImporter < BaseImporter
      def import
        output = {}
        # normalise data
        nodes.each_key do |network_id|
          net = nodes[network_id]
          normalised_nodes = net.map do |node|
            {
              node_id: node['nodeId'],
              node_name: node['name'],
              node_addrs: node['config']['ipAssignments'],
              node_authed: node['config']['authorized']
            }
          end
          # TODO: finish implementation
        end
      end
    end
  end
end

