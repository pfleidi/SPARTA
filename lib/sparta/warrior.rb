require 'rubygems'
require 'bundler/setup'

require 'sshkey'
require 'net/ssh'

module Sparta
  class Warrior
    attr_reader :instance, :provider, :credentials

    def initialize(env = {})
      @provider = env[:provider]
      @credentials = env[:credentials]

      @instance = Providers.providers[@provider].create_instance(env)
    end

    def kill
      Providers.providers[@provider].destroy_instance({
        :id => @instance[:id], 
        :credentials => @credentials
      })
    end

    def arm

    end

    def fight

    end

    def ssh(command)
      Net::SSH.start(@instance[:host], @instance[:username], {:key_data  => @instance[:private_key]}) do |ssh|
        ssh.exec(command)
      end
    end

    def package_manager
    end
  end
end
