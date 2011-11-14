require 'rubygems'
require 'bundler/setup'

require 'sshkey'

module Sparta
  class Warrior
    def initialize(env = {})
      @provider = env[:provider]
      @credentials = env[:credentials]
      @key_pair = SSHKey.generate

      env[:private_key] = @key_pair.private_key
      env[:public_key] = @key_pair.ssh_public_key

      @id = Providers.providers[@provider].create_instance(env)
    end

    def kill(env = {})
      Providers.providers[@provider].destroy_instance({
        :id => @instance_data[:id], 
        :credentials => env[:credentials]
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
