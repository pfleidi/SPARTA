require 'rubygems'
require 'bundler/setup'
require 'net/netrc'
require "fog"

class AmazonEC2 < Sparta::BootCamp
  def initialize(credentials, opts)
    @credentials = credentials
    @opts = opts
  end

  def connect!(env = {})
    @connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => @credentials.login,
      :aws_secret_access_key => @credentials.password,
      })

      @instance = @connection.servers.bootstrap({:private_key_path => '~/.ssh/id_rsa', :public_key_path => '~/.ssh/id_rsa.pub'})
      Sparta::BootCamp.running_instances << @instance
      @instance.id
    end

    def kill!
      @instance.destroy
    end
    
    def ssh(command = "")
      @instance.ssh(command)
    end
  end
