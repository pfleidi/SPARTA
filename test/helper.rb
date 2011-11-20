require 'rubygems'
require 'bundler/setup'
require 'test/unit'

require 'sparta'
require 'mocha'
require 'fog'

at_exit do
  Sparta::BootCamp.killall
  puts "Pulling a reiser."
end