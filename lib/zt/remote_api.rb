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
        self.class.get '/network', @req_opts
      end

      def network_members(network_id)
        self.class.get "/network/#{network_id}/member", @req_opts
      end

    end
  end
end
