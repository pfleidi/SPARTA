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
      # try to load from credentials file 
      new_credentials = nil
      credential_file = File.open('config/credentials.yaml')
      if ( credential_file )
        contents = YAML.load(credential_file)
        if ( contents[provider] )
          provider_contents = contents[provider]
          new_credentials = Credentials.new(provider_contents['id'], provider_contents['key'])
        end
      end
      
      # if there are no credentials here, see for .netrc
      
      if ( !new_credentials )
        credentials = Net::Netrc.locate("sparta.#{provider}")
        if ( credentials )
          new_credentials = Credentials.new(credentials.login, credentials.password)
        end
      end
      
      new_credentials ||= Credentials.new(nil,nil) 
      
      return new_credentials
    end
  end
end
