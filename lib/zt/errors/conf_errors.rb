# frozen_string_literal: true

module Zt
  module Errors
    # Config does not exist on disk and cannot be created
    class ZtConfDiskError < StandardError
      def initialize
        super
      end
    end

    # Config exists on disk but cannot be parsed
    class ZtConfSyntaxError < StandardError
      def initialize
        super
      end
    end
  end
end
