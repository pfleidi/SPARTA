require 'rubygems'
require 'bundler/setup'

require 'sshkey'

module Sparta
  class Warrior
    attr_reader :instance, :provider, :key_pair, :credentials

    def initialize(env = {})
      @provider = env[:provider]
      @credentials = env[:credentials]
      @key_pair = SSHKey.generate

      env[:private_key] = @key_pair.private_key
      env[:public_key] = @key_pair.ssh_public_key

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

    def ssh(commands = [])
    end
  end
end
