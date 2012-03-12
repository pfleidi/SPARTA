require 'rubygems'
require 'bundler/setup'
#require 'net/ssh'

require 'timeout'
require 'celluloid'

module Sparta
  class Warrior   

    attr_accessor :state, :weapon, :bootcamp

    def initialize(bootcamp_params = {})
      begin
        Timeout::timeout(360) do
          @bootcamp = Sparta::BootCamp.create_instance(bootcamp_params)
          @instance_id = @bootcamp.connect!
          self
        end
      rescue
        raise "Warrior init failed"
      end
    end

    def arm(weapon)
      @weapon = weapon
      @weapon.install(@bootcamp)

      if(@weapon.is_working?)
        begin
          @bootcamp.add_tag('weapon', weapon.class.name)
        rescue
        end
      else
        @weapon = nil
      end
    end

    def is_armed?
      @weapon.is_working?
    end

    def attack(target, options={})
      raise "need a target!" unless target
      raise "need a connection!" unless self.bootcamp
      @weapon.use(target, options)
    end

    def kill
      @bootcamp.kill!
    end

    def ssh(command = "")
      @bootcamp.ssh(command)
    end
  end
end
