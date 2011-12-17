require 'rubygems'
require 'bundler/setup'
require 'net/netrc'
require "fog"

class AmazonEC2 < Sparta::BootCamp

  def initialize(credentials, opts = {})
    @credentials = credentials
    @opts = opts
  end

  def connect!(env = {})
    # SSH key pair name
    Fog.credential = @opts[:key_pair_name] || :sparta_key_pair

    @connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => @credentials.login,
      :aws_secret_access_key => @credentials.password,
    })


    @instance = @connection.servers.bootstrap(
      :private_key_path => '~/.ssh/id_rsa',
      :public_key_path  => '~/.ssh/id_rsa.pub',
      :tags => {:sparta_session_id => Sparta::session_uuid}
    )
    Sparta::BootCamp.running_instances << @instance

    @instance.id
  end

  def kill!
    @instance.destroy
  end

  def add_tag(key, value)
    tag = @connection.tags.create(:resource_id => @instance.id, :key => key, :value => value)
  end
end
