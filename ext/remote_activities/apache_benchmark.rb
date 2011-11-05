#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

module ApacheBenchmarkActivity

  def install(installer)
    installer.run([
        'aptitude install apache2-utils',
        'apt-get install apache2-utils',
        'pacman -S apache'
    ])
  end

  def execute(options = {})
    server = options[:server]
    server.run("ab -k -n #{options[:requests]} -n #{options[:clients]}")
  end

  def parse(output)
    # return parsed data structure of string output
  end

end
