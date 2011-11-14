require 'rubygems'
require 'bundler/setup'

require 'wrapper/fog_provider_wrapper'
require 'fog'

class Rackspace < Sparta::Providers
  def self.connect(env = {})
    name = self.name.to_s.downcase.to_sym

    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.providers[name]

    #Rackspace_auth_url for european rackspace instances
    connection = Fog::Compute.new({
      :provider => 'Rackspace',
      :rackspace_username => credentials[:id],
      :rackspace_api_key => credentials[:key],
      :rackspace_auth_url => "lon.auth.api.rackspacecloud.com"
    })
  end

  def self.create_instance(env = {})
    connection = connect(env)
    instance = connection.servers.bootstrap(env)

    instance_data = {
      :host => instance.addresses['public'],
      :id => instance.id
    }
  end

  def self.destroy_instance(env = {})
    connection = connect(env)
    connection.servers.get(env[:id]).destroy
  end
end
