# frozen_string_literal: true

require 'yaml'
require 'xdg'

module Zt
  # Create initial config if it is not present already
  class Conf
    include Singleton
    INITIAL_CONF = {
      'networks.yaml' => [{}],
      'nodes.yaml' => [{}],
      'zt.conf.yaml' => {
        update_networks: true,
        update_nodes: true
      }
    }.freeze

    def initialize
      raise Errors::ZtConfDiskError unless ensure_config_on_disk
      raise Errors::ZtConfSyntaxError unless read_config
    end

    private

    def read_config
      true
    end

    def ensure_config_on_disk
      ensure_config_dir && ensure_config_files
    end

    def ensure_config_files(config_dir = "#{XDG['CONFIG_HOME']}/zt")
      existing_files = []
      created_files = []
      %w[networks.yaml nodes.yaml zt.conf.yaml].each do |config_file|
        if File.exist?("#{config_dir}/#{config_file}")
          existing_files += config_file
        elsif create_config_file("#{config_dir}/#{config_file}",
                                 INITIAL_CONF[config_file])
          created_files += config_file
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
