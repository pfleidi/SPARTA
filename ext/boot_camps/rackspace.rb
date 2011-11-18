require 'rubygems'
require 'bundler/setup'

require 'fog'
require 'sshkey'

class Rackspace < Sparta::BootCamp
  def self.connect(env = {})
    name = self.name.to_s.downcase.to_sym

    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.boot_camps[name]

    parameters = {
      :provider => 'Rackspace',
      :rackspace_username => credentials[:id],
      :rackspace_api_key => credentials[:key],
    }
    
    #rackspace auth url differs for UK region
    if(env[:site] == 'uk')
      parameters[:rackspace_auth_url] = "lon.auth.api.rackspacecloud.com" 
    end
    
    connection = Fog::Compute.new(parameters)
  end

  def self.create_instance(env = {})
    connection = connect(env)


    key_pair = SSHKey.generate
    env[:public_key] = key_pair.ssh_public_key

    instance = connection.servers.bootstrap(env)
    instance.wait_for { ready? }

    begin
      Timeout::timeout(360) do
        begin
          Timeout::timeout(8) do
            Net::SSH.start(instance.addresses['public'].first, instance.username, {:key_data => key_pair.private_key}) do |ssh|
              ssh.exec('pwd')
            end
          end
        rescue Errno::ECONNREFUSED
          sleep(2)
          retry
        rescue Net::SSH::AuthenticationFailed, Timeout::Error
          retry
        end
      end

    rescue Timeout::Error
      instance.destroy
      raise "Timeout occured. Instance (#{instance.id}, #{self.name}) has been destroyed"
    end

    {
      :id => instance.id,
      :username => instance.username,
      :private_key => key_pair.private_key,
      :host => instance.addresses['public'].first
    }
  end

  def self.destroy_instance(env = {})
    connection = connect(env)
    connection.servers.get(env[:id]).destroy
  end
end
