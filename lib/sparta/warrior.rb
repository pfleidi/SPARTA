require 'rubygems'
require 'bundler/setup'

require 'net/ssh'

module Sparta
  class Warrior   
    attr_accessor :state
    attr_accessor :ssh
    attr_accessor :target 
    def initialize(conn)
      @ssh = conn
    end
    
    def arm(weapon)
      @weapon = weapon
      @weapon.install(@ssh)
      @weapon = nil unless @weapon.is_working?
        
    end
    
    def is_armed?
      not @weapon.nil?
    end
    
    def attack! 
      raise "need a target!" unless self.target
      raise "need a connection!" unless self.ssh
      @weapon.use(target)
    end
  end
end
