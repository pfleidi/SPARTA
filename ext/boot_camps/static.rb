require 'rubygems'
require 'bundler/setup'
require 'net/ssh'

class StaticProvider < Sparta::BootCamp
  attr_reader :instance

  def initialize(*args)
    env = args[1]
    @instance = {}
    @@known_hosts ||= []

    if(env[:host])
      if(env[:host].class == Array)
        env[:host].each do |h|
          unless(@@known_hosts.index(h))
            @@known_hosts << h
            @instance[:host] = h
            break
          end
        end
      else
        @instance[:host] = env[:host]
      end
    end

    @instance[:host] ||= '127.0.0.1'
    @instance[:private_key] = env[:pk_path] || '~/.ssh/id_rsa'
    @instance[:username] = env[:username] || 'root'
    @instance[:ssh_port] = env[:ssh_port] || '22'
   end

  def connect!(env = {})
    puts "connecting to #{@instance[:host]}!\n"
  end

  def kill!
    raise "kill! not supported for static warriors"
  end

  def ssh(command = "")
    result = {:stdout => [], :stderr => []}

    Net::SSH.start(@instance[:host], @instance[:username], :keys => ['~/.ssh/id_rsa']) do |ssh|
      channel = ssh.open_channel do |ch|
        ch.exec(command) do |ch, success|
          raise "ssh #{@instance[:host]}: error executing command" unless success

          ch.on_data do |c, data|
            result[:stdout] << data
          end

          ch.on_extended_data do |c, data|
            result[:stderr] << data
          end
        end
      end

      channel.wait
    end
    return result
  end
end
