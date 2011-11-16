require 'rubygems'
require 'bundler/setup'

module Sparta
  class Providers
    def self.providers
      @providers ||= {}
    end

    def self.inherited(child)
      providerName = child.name.to_s.downcase.to_sym
      self.providers[providerName] = child
    end

    def self.load_providers
      path = "ext/boot_camps"
      $LOAD_PATH.unshift(path)

      Dir[File.join(path, "*.rb")].each do |provider|
        require File.basename(provider)
      end
    end
  end
end
