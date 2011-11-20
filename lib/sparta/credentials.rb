require 'rubygems'
require 'bundler/setup'

module Sparta
  module Credentials
    def self.boot_camps
      @boot_camps ||= {}
    end
  end
end
