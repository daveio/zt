# frozen_string_literal: true

module Zt
  module Exporters
    class BaseExporter
      attr_accessor :data
      def initialize
        super
      end

      def export
        abort('export called on non-functional superclass exporter')
      end
    end
  end
end
