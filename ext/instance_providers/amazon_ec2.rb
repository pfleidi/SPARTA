require 'fog'

class AmazonEC2 < Sparta::Providers
  def self.create_instance(env = {})
    connection = self.connect(env)

    instance = connection.servers.create
    instance.wait_for { ready? }

    instance.id
  end

  def self.destroy_instance(env = {})
    connection = self.connect(env)
    instance = connection.servers.get(env[:id]).destroy
  end

  def self.connect(env = {})
    Fog.mock!
    name = self.name.to_s.downcase.to_sym

    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.providers[name]

    connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => credentials[:id],
      :aws_secret_access_key => credentials[:key]
    })
  end
end
