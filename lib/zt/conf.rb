# frozen_string_literal: true

require 'ostruct'
require 'singleton'
require 'xdg'
require 'yaml'

module Zt
  # Create initial config if it is not present already
  class Conf
    include Singleton
    attr_accessor :conf
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
        'api_key' => 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX',
        'top_level_domain' => 'zt'
      }
    }.freeze

    def initialize
      raise Errors::ZtConfDiskError unless ensure_config_on_disk
      raise Errors::ZtConfSyntaxError unless read_config
    end

    private

    def read_config
      @conf = OpenStruct.new
      CONF_SECTIONS.each_key do |section|
        @conf[section] =
          YAML.load_file("#{CONF_DIR}/#{CONF_SECTIONS[section]}")
      end
      true
    rescue StandardError
      false
    end

    def ensure_config_on_disk
      ensure_config_dir && ensure_config_files
    end

    def ensure_config_files
      existing_files = []
      created_files = []
      INITIAL_CONF.keys.each do |config_file|
        if File.exist?("#{CONF_DIR}/#{config_file}")
          existing_files.append(config_file)
        elsif create_config_file("#{CONF_DIR}/#{config_file}",
                                 INITIAL_CONF[config_file])
          created_files.append(config_file)
        end
      end
      (existing_files + created_files).uniq.sort == INITIAL_CONF.keys.sort
    end

    def create_config_file(path, content)
      File.open(path, 'w') do |f|
        YAML.dump(content, f)
      end
      true
    rescue StandardError
      false
    end

    def ensure_config_dir
      if Dir.exist? "#{XDG['CONFIG_HOME']}/zt"
        dir_exists = true
        dir_created = false
      else
        dir_exists = false
        dir_created = create_config_dir("#{XDG['CONFIG_HOME']}/zt")
      end
      dir_created || dir_exists
    end

    def create_config_dir(path)
      Dir.mkdir(path)
      true
    rescue StandardError
      false
    end
  end
end
