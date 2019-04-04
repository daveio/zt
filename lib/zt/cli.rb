require 'thor'
require 'zt'
module Zt
  class CLI < Thor

    desc "version", "Show the zt version number"
    def version
      puts "This is zt version #{Zt::VERSION}"
    end

  end
end
