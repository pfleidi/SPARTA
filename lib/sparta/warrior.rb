require 'rubygems'
require 'bundler/setup'
require 'net/ssh'

require 'timeout'

module Sparta
  class Warrior   
    attr_accessor :state
    attr_accessor :weapon
    attr_accessor :bootcamp

    def initialize(bootcamp_params = {})
      begin
        Timeout::timeout(360) do
          @bootcamp = Sparta::BootCamp.create_instance(bootcamp_params)
          @bootcamp.connect!
        end
      rescue
        raise "Warrior initialization failed"
      end
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

    def kill!
      @bootcamp.kill!
    end

    def ssh(command = "")
      @bootcamp.ssh(command)
    end
  end
end
