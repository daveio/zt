# frozen_string_literal: true

require 'xdg'

module Zt
  module Constants
    ALL_EXPORTERS = %w[
      HostsFileExporter
    ].freeze
    ALL_IMPORTERS = %w[
      NetworkImporter
      NodeImporter
    ].freeze
    AUTH_TOKEN_LENGTH = 32
    AUTH_TOKEN_REGEX = /^[A-Za-z0-9]+$/.freeze
    CONF_DIR = "#{XDG['CONFIG_HOME']}/zt"
    CONF_SECTIONS = {
      domains: 'domains.yaml',
      networks: 'networks.yaml',
      nodes: 'nodes.yaml',
      zt: 'zt.conf.yaml'
    }.freeze
    # noinspection RubyStringKeysInHashInspection
    INITIAL_CONF = {
      'nodes.yaml' => {
        'node_id' => {
          'hostname' => 'node-hostname',
          'networks' => %w[network_id_1 network_id_2]
        }
      },
      'networks.yaml' => {
        'network_id' => {
          'name' => 'network_name'
        }
      },
      'domains.yaml' => {
        'network_id' => 'domain-name.zt'
      },
      'zt.conf.yaml' => {
        'manual_pulls' => false,
        'token' => 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
        'top_level_domain' => 'zt'
      }
    }.freeze
  end
end
