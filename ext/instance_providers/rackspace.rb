require 'rubygems'
require 'bundler/setup'

require 'wrapper/fog_provider_wrapper'

class Rackspace < Sparta::Providers
  include FogInstanceProvider
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
end
