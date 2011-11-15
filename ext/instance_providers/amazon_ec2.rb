require 'rubygems'
require 'bundler/setup'

require "fog"

class AmazonEC2 < Sparta::Providers

  def self.connect(env = {})
    name = self.name.to_s.downcase.to_sym

    credentials = env[:credentials]
    credentials ||= Sparta::Credentials.providers[name]

    connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => credentials[:id],
      :aws_secret_access_key => credentials[:key],
    })
  end

  def self.create_instance(env = {})
    connection = connect(env)
    
    if connection.key_pairs.get('sparta_tmp_kp')
      connection.key_pairs.get('sparta_tmp_kp').destroy
    end

    key_pair = connection.key_pairs.create(:name => 'sparta_tmp_kp')
    env[:key_pair] = key_pair

    instance = connection.servers.create(env)
    instance.wait_for { ready? }

    begin
      Timeout::timeout(360) do
        begin
          Timeout::timeout(8) do
            Net::SSH.start(instance.public_ip_address, instance.username, {:key_data => key_pair.private_key}) do |ssh|
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
    end
    
    instance_data = {
      :id => instance.id,
      :username => instance.username,
      :private_key => key_pair.private_key,
      :host => instance.public_ip_address
    }
  end

  def self.destroy_instance(env = {})
    connection = connect(env)
    connection.servers.get(env[:id]).destroy
  end
end
