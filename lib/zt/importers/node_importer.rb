# frozen_string_literal: true

require 'zt/importers/_base_importer'

module Zt
  module Importers
    class NodeImporter < BaseImporter
      def import
        output = {}
        hostnames = {}
        memberships = {}
        # normalise data
        nodes.each_key do |network_id|
          net = nodes[network_id]
          normalised_nodes = net.map do |node|
            {
              node_id: node['nodeId'],
              node_name: node['name'],
              node_addr: node['config']['ipAssignments'],
              node_authed: node['config']['authorized']
            }
          end
          normalised_nodes.each do |n|
            hostnames[n[:node_id]] = [] unless hostnames.key?(n[:node_id])
            memberships[n[:node_id]] = [] unless memberships.key?(n[:node_id])

            hostnames[n[:node_id]].append(n[:node_name])
            memberships[n[:node_id]].append([network_id, n[:node_addr]])
            n.delete(:node_addr)
            output[n[:node_id]] = {} unless output.key?(n[:node_id])
            output[n[:node_id]][:remote] = n
            output[n[:node_id]][:local] = {}
          end
          output.each_key do |k|
            output[k][:remote][:node_name] = hostnames[k].max_by do |i|
              hostnames[k].count(i)
            end
            memberships[k].each do |m|
              output[k][:local][:networks] = {} unless
                output[k][:local].key? :networks

              output[k][:local][:networks][m[0]] = m[1]
            end

          end
        end
        {
          nodes: output
        }
      end
    end
  end
end

