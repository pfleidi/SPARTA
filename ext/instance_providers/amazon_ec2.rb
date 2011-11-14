require 'rubygems'
require 'bundler/setup'

require 'wrapper/fog_provider_wrapper'
require "fog"

class AmazonEC2 < Sparta::Providers
  def self.connect(env = {})
    name = self.name.to_s.downcase.to_sym

    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.providers[name]

    connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => credentials[:id],
      :aws_secret_access_key => credentials[:key]
    })
  end

  def self.create_instance(env = {})
    connection = connect(env)
    instance = connection.servers.bootstrap(env)
  end

  def self.destroy_instance(env = {})
    connection = connect(env)
    connection.servers.get(env[:id]).destroy
  end
end
