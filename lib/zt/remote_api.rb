# frozen_string_literal: true

require 'httparty'
require 'zt/conf'

module Zt
  module RemoteAPI
    class ZeroTierAPI
      include HTTParty

      base_uri 'https://my.zerotier.com/api'

      def initialize
        @ztc = Zt::Conf.instance.conf
        # noinspection RubyStringKeysInHashInspection
        @req_opts = {
          headers: {
            'Authorization' => "Bearer #{@ztc.zt['token']}"
          }
        }
      end

      def networks
        get_parsed('/network')
      end

      def network_members(network_id)
        get_parsed("/network/#{network_id}/member")
      end

      private

      def get_parsed(path)
        self.class.get(path, @req_opts).parsed_response
      end

    end
  end
end
