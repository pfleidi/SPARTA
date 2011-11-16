require 'rubygems'
require 'bundler/setup'

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
      result = {:stdout => [], :stderr => []}
      Net::SSH.start(@instance[:host], @instance[:username], {:key_data  => @instance[:private_key]}) do |ssh|
        channel = ssh.open_channel do |ch|
          ch.exec(command) do |ch, success|
            raise "ssh #{@instance[:host]}: error executing command" unless success

            ch.on_data do |c, data|
              result[:stdout] << data
            end

            ch.on_extended_data do |c, data|
              result[:stderr] << err
            end
          end
        end

        channel.wait
      end

      return result
    end

    def package_manager
    end
  end
end
