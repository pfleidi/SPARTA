require 'rubygems'
require 'bundler/setup'

require 'celluloid'

module Sparta
  class Squad
    attr_reader :warriors

    def initialize(count, env = {})
      @warriors = []
      add_warriors(count, env)
    end

    def add_warriors(count, env = {})
      futures = []

      count.times do futures << Celluloid::Future.new { Warrior.new env }

      Timeout::timeout(360) do
        futures.each do |f|
          begin
            Timeout::timeout(8) do
              if(f.value)
                @warriors << f.value
              end
            end
          rescue
            sleep(2)
            retry
          end
        end
      end
    end

    def arm(weapon)
      @warriors.each do |w| 
        w.arm(weapon)
      end
    end

    def is_armed?
      @warriors.map { |warrior| warrior.is_armed? }.all?
    end

    def attack!(env = {})

      if(env[:ramp_up])
        ramp_up_time = env[:ramp_up][:period]
        raise "Squad attack ramp up: period missing" unless ramp_up_time

        ramp_up_function = env[:ramp_up][:function] || :linear

        if ramp_up_function == :linear
          delays = Array.new(@warriors.size){ramp_up_time / @warriors.size}
          @warriors.each_with_index { |warrior,index| warrior.attack('http://localhost/'); sleep(delays[index]);}
        end
      else
        @warriors.each { |warrior| warrior.attack('http://localhost') }
      end
    end

    def kill!
      @warriors.each { |warrior| warrior.kill }
      @warriors.clear
    end
  end
end
