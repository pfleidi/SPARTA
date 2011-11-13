require 'rubygems'
require 'bundler/setup'

require 'wrapper/fog_provider_wrapper'

class AmazonEC2 < Sparta::Providers
  include FogInstanceProvider

  def self.connect(env = {})
    name = self.name.to_s.downcase.to_sym
    Fog.mock!
    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.providers[name]

    connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => credentials[:id],
      :aws_secret_access_key => credentials[:key]
    })
  end
end
