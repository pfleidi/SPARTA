#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

module ApacheBenchmarkActivity

  def install(env)
    env.install({
        :apt=>'aptitude install apache2-utils',
        :pacman=>'pacman -S apache',
        :yum => 'init 0'
    })
  end

  def execute(env, options)    
    env.run do |shell|
      shell.exec("ab -k -n #{options[:requests]} -n #{options[:clients]}")    
    end
    
    env.join!
  end

  def parse(output)
    # return parsed data structure of string output
  end

end
