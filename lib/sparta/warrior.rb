require 'rubygems'
require 'bundler/setup'

require 'net/ssh'

module Sparta
  class Warrior    
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
      @weapon.use()
    end
  end
end
