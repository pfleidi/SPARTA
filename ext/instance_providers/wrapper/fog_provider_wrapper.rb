require 'rubygems'
require 'bundler/setup'

module FogProviderWrapper
  def self.included receiver
    receiver.extend ClassMethods
  end

  module ClassMethods
    def create_instance(env = {})
      connection = connect(env)
      instance = connection.servers.create
      instance.wait_for { ready? }
      instance.id
    end

    def destroy_instance(env = {})
      connection = connect(env)
      connection.servers.get(env[:id]).destroy
    end
  end
end

