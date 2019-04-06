# frozen_string_literal: true

require 'zt/constants'
require 'zt/exporters/_base_exporter'
require 'zt/exporters/hosts_file_exporter'

module Zt
  module Exporters
    class Exporter
      def initialize(data, *exporter_names)
        exporter_names = Zt::Constants::ALL_EXPORTERS if exporter_names.empty?

        exporter_classes = exporter_names.map { |n| Zt::Exporters.const_get(n) }
        @exporters = exporter_classes.map { |c| c.new(data) }
      end

      # @return [Array[Hash]] an array of hashes from each exporter
      # The hash is in form { data: Object, mangle: lambda }
      # with the :mangle lambda containing any steps to apply the Object
      # like rewriting /etc/hosts or sending the data elsewhere.
      # NOTE there may be value in attributing each hash to its
      # importer, consider that for later as a Hash[Hash].
      def export
        @exporters.map(&:export)
      end
    end
  end
end
