# frozen_string_literal: true

require 'zt/constants'
require 'zt/importers/_base_importer'
require 'zt/importers/network_importer'
require 'zt/importers/node_importer'

module Zt
  module Importers
    class Importer
      def initialize(networks, nodes, *importer_names)
        importer_names = Zt::Constants::ALL_IMPORTERS if importer_names.empty?
        importer_classes = importer_names.map do |n|
          Zt::Importers.const_get(n)
        end
        @importers = importer_classes.map { |c| c.new(networks, nodes) }
      end

      # @return [Array[Hash]] an array of hashes from each exporter.
      # NOTE there may be value in attributing each hash to its
      # importer, consider that for later as a Hash[Hash].
      def import
        @importers.map(&:import)
      end
    end
  end
end
