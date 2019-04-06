# frozen_string_literal: true

module Zt
  module Importers
    class BaseImporter
      def initialize(networks, nodes)
        @networks = networks
        @nodes = nodes
      end

      def import
        abort('import called on non-functional superclass importer')
      end
    end
  end
end
