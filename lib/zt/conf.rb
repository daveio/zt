# frozen_string_literal: true

require 'ostruct'
require 'singleton'
require 'yaml'
require 'zt/constants'
require 'zt/errors'

module Zt
  # Create initial config if it is not present already
  class Conf
    include Singleton
    attr_accessor :conf

    def initialize
      raise Errors::ZtConfDiskError unless ensure_config_on_disk
      raise Errors::ZtConfSyntaxError unless read_config
    end

    def save!(*sections)
      sections = %i[domains networks nodes zt] if sections.empty?
      sections.each do |section|
        File.open(full_path_for_section(section), 'w') do |f|
          YAML.dump(@conf[section], f)
        end
      end
    end

    private

    def full_path_for_section(section)
      raise Errors::ZtConfInvalidSectionError unless
        Constants::CONF_SECTIONS.key? section

      "#{Constants::CONF_DIR}/#{Constants::CONF_SECTIONS[section]}"
    end

    def read_config
      @conf = OpenStruct.new
      Constants::CONF_SECTIONS.each_key do |section|
        @conf[section] =
          YAML.load_file(
            "#{Constants::CONF_DIR}/#{Constants::CONF_SECTIONS[section]}"
          )
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
      Constants::INITIAL_CONF.keys.each do |config_file|
        if File.exist?("#{Constants::CONF_DIR}/#{config_file}")
          existing_files.append(config_file)
        elsif create_config_file("#{Constants::CONF_DIR}/#{config_file}",
                                 Constants::INITIAL_CONF[config_file])
          created_files.append(config_file)
        end
      end
      (existing_files + created_files).uniq.sort ==
        Constants::INITIAL_CONF.keys.sort
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
      if Dir.exist? Constants::CONF_DIR
        dir_exists = true
        dir_created = false
      else
        dir_exists = false
        dir_created = create_config_dir(Constants::CONF_DIR)
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
