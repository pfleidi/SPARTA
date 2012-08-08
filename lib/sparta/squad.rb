require 'rubygems'
require 'thread'

module Sparta
  class Squad
    attr_reader :warriors

    def initialize(count, env = {})
      @warriors = Barrack.new
      add_warriors(count, env)
    end

    def arm(&weapon)
      @armed_weapon = weapon
      @warriors.each! { |warrior| warrior.arm(weapon.call) }
    end

    def is_armed?
      @warriors.map { |warrior| warrior.is_armed? }.all?
    end

    def attack!(target, options={})
        @warriors.each! { |warrior| warrior.attack(target,options) }
    end

    def rearm
      @warriors.each! { |warrior| warrior.arm(@armed_weapon.call) }
    end

    def report!(options={})
      result_queue = Queue.new

      @warriors.each! { |warrior| result_queue << warrior.report }
      
      results = []
      
      while result_queue.length != 0
        results << result_queue.pop
      end

      @warriors.first.weapon.merge(results, options)
    end

    def kill!
      @warriors.each! { |warrior| warrior.kill }
      @warriors.clear
    end

    def create_warriors
      @warriors.each! do |warrior|
        warrior.create
      end
    end

    def add_warriors(count, env)
      provider = env[:provider].to_s
      credentials = Credentials.provide_for_provider(provider)
      count.times { @warriors << Warrior.new(BootCamp.create(credentials, env)) }

      self.create_warriors
    end
  end
end
