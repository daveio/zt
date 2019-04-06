# frozen_string_literal: true

require 'zt/exporters/_base_exporter'

module Zt
  module Exporters
    class HostsFileExporter < BaseExporter
      def export
        # process the normalised Hash @data and return a String and a Block
        # defining what to do with the String
      end
    end
  end
end
