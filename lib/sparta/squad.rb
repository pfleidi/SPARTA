require 'rubygems'

module Sparta

  class Squad
    attr_reader :warriors

    def initialize(count, env = {})
      @warriors = []
      add_warriors(count, env)
    end

    def arm
      @warriors.each { |warrior| warrior.arm(yield) }
    end

    def is_armed?
      @warriors.map { |warrior| warrior.is_armed? }.all?
    end

    def attack!(env = {})
      if env[:ramp_up]
        ramp_up_time = env[:ramp_up][:period]
        raise "Squad attack ramp up: period missing" unless ramp_up_time

        ramp_up_function = env[:ramp_up][:function] || :linear

        if ramp_up_function == :linear
          delays = Array.new(@warriors.size) { ramp_up_time / @warriors.size }
          @warriors.each_with_index do |warrior, index|
            warrior.attack('http://localhost/'); sleep(delays[index]);
          end
        end
      else
        @warriors.each { |warrior| warrior.attack('http://localhost') }
      end
    end

    def kill!
      @warriors.each { |warrior| warrior.kill }
      @warriors.clear
    end

    private

    def add_warriors(count, env)
      count.times { @warriors << Warrior.new(BootCamp.create(env)) }
    end

  end

end
