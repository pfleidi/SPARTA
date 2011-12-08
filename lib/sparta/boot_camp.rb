require 'rubygems'
require 'bundler/setup'

module Sparta
  class BootCamp
    attr_reader :connection
    attr_reader :ssh
    attr_reader :credentials
    
    def initialize(credentials, options)
      raise "Not Implemented in base class"
    end
    
    
    def self.boot_camps
      @boot_camps ||= {}
    end

    def self.create_instance(opts)
      provider = opts[:provider].to_s.downcase
      raise 'Need an provider to instantiate bootcamp' unless provider
      className = boot_camps[provider.to_s.downcase.to_sym]
      raise "Provider #{provider.to_s} is unknown." unless className
      
      credentials = Sparta::Credentials.provide_for_provider(opts[:provider])
      return className.new(credentials, opts)
    end
    
    def ssh (args = [])
      @connection.ssh(args) 
    end
    
    def self.inherited(child)
      puts "Loaded #{child}"
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
    
    def self.running_instances
      @running_instances ||= []
    end
    
    def self.killall
      running_instances.each do |victim|
        victim.destroy
      end
    end
    
    def new_warrior
      return Sparta::Warrior.new(@ssh)
    end
    
    def connect!
      raise "Not implemented in base class."
    end
  end
end

Sparta::BootCamp.load_boot_camps
