require 'rubygems'
require 'bundler/setup'

require "fog"

class AmazonEC2 < Sparta::BootCamp



  def initialize(opts)

    @credentials                = opts[:credentials]


  end

  def connect!(env = {})
    @connection = Fog::Compute.new({
      :provider => 'AWS',
      :aws_access_key_id => @credentials [:access_id],
      :aws_secret_access_key => @credentials [:secret_access_key],
      })

      @instance = @connection.servers.bootstrap({:private_key_path => '~/.ssh/id_rsa', :public_key_path => '~/.ssh/id_rsa.pub'})
      Sparta::BootCamp.running_instances << @instance
      
      puts "Launched instance."
      args = @instance.ssh('ifconfig')
      puts args.inspect
=begin
      begin
        Timeout::timeout(60) do
          begin
            Timeout::timeout(20) do
         
            end
          rescue Errno::ECONNREFUSED
            sleep(2)
            retry
          rescue Timeout::Error
            retry
          rescue Net::SSH::AuthenticationFailed
            puts "Silly you."
          end
        end 

      rescue Timeout::Error
         @instance.destroy
        raise "Timeout occured. Instance (#{@instance.id}, #{self.class.to_s}) has been destroyed"
      end
=end

    end

    def self.destroy_instance(env = {})
      connection = connect(env)
      connection.servers.get(env[:id]).destroy
    end
  end
