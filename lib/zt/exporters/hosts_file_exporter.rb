# frozen_string_literal: true

require 'zt/exporters/_base_exporter'
require 'zt/conf'

module Zt
  module Exporters
    class HostsFileExporter < BaseExporter
      def export
        # process the normalised Hash @data and return a String and a Block
        # defining what to do with the String
        conf = Zt::Conf.instance.conf
        output = ''
        conf.nodes.each_key do |node_id|
          node = conf.nodes[node_id]
          node_nets = node[:local][:networks]
          node_nets.each_key do |net_id|
            net_zone = conf.networks[net_id][:local][:dns_zone]
            node_name = node[:remote][:node_name]
            node_addrs = node[:local][:networks][net_id]
            node_addrs.each do |node_addr|
              output += "#{node_addr}\t\t#{node_name}.#{net_zone}\n"
            end
          end
        end
        "# BEGIN zt\n" + output.lines.sort_by do |a|
          a.split[1]
        end.join + "# END zt\n"
      end
    end
  end
end
