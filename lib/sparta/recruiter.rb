require 'rubygems'
require 'bundler/setup'

module Sparta
  class BootCamp
    def self.boot_camps
      @boot_camps ||= {}
    end

    def self.inherited(child)
      bootcampName = child.name.to_s.downcase.to_sym
      self.boot_camps[bootcampName] = child
    end

    def self.load_boot_camps
      path = "ext/boot_camps"
      $LOAD_PATH.unshift(path)
      Dir[File.join(path, "*.rb")].each do |bootcamp|
        require File.basename(bootcamp)
      end
    end
  end
end
