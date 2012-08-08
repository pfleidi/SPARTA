require 'rubygems'
require 'bundler/setup'

module Sparta
  class Credentials
    attr_reader :login
    attr_reader :password

    def initialize(login,password)
      @login = login
      @password = password
    end

    def self.provide_for_provider(provider)
      provider = provider.to_s
      # try to load from credentials file
      config_path =  File.join(File.dirname(__FILE__), "../../config", "credentials.yaml")
      credential_file = File.open(config_path)
      
      if credential_file
        contents = YAML.load(credential_file)
        if contents[provider]
          provider_contents = contents[provider]
          new_credentials = Credentials.new(provider_contents['id'], provider_contents['key'])
        end
      end

      # if there are no credentials here, see for .netrc

      if new_credentials.nil?
        credentials = Net::Netrc.locate("sparta.#{provider}")
        if credentials
          new_credentials = Credentials.new(credentials.login, credentials.password)
        end
      end

      raise "No credentials found for #{provider}" if new_credentials.nil?
      
      new_credentials
    end
  end
end
