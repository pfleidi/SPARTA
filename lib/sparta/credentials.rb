require 'rubygems'
require 'bundler/setup'

module Sparta
  module Credentials
    def self.providers
      @providers ||= {}
    end
  end
end
