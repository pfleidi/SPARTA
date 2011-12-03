require 'rubygems'
require 'bundler/setup'
require 'net/ssh'

module Sparta
  class Warrior   
    attr_accessor :state
    attr_accessor :weapon
    attr_accessor :bootcamp

    def initialize(bootcamp_params = {})
      @bootcamp = Sparta::BootCamp.create_instance(bootcamp_params)
      @bootcamp.connect!
    end

    def arm(weapon)
      @weapon = weapon
      @weapon.install(@bootcamp)

      @weapon = nil unless @weapon.is_working?
    end

    def is_armed?
      not @weapon.nil?
    end

    def attack!(target, options={})
      raise "need a target!" unless target
      raise "need a connection!" unless self.bootcamp
      @weapon.use(target, options)
    end

    def kill
      @bootcamp.kill!
    end
  end
end
