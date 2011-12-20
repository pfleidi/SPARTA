require './lib/sparta/warrior'

module Sparta
  class Squad
    attr_reader :warriors

    def initialize(count, env = {})
      @warriors = []
      add_warriors(count, env)
    end

    def add_warriors(count, env = {})
      threads = []

      (0 ... count).each do |number|
        threads << Thread.new do
          retry_count = env[:max_retry] || 0

          begin
            @warriors << Warrior.new(env)
          rescue
            if retry_count > 0
              retry_count -= 1
              retry
            else

              raise "Warrior not reachable after #{env[:max_retry]} retries."
            end
          end
        end
      end

      threads.each do |t|
        t.join
      end

    end

    def arm(weapon)
      @warriors.each do |w| 
        w.arm(weapon)
      end
    end

    def is_armed?
      @warriors.each do |warrior|
        return false if not warrior.is_armed?
      end

      return true
    end

    def attack!(env = {})
      if(env[:ramp_up])
        ramp_up_time = env[:ramp_up][:period]
        raise "Squad attack ramp up: period missing" unless ramp_up_time

        ramp_up_function = env[:ramp_up][:function] || :linear

        if ramp_up_function == :linear
          delays = Array.new(@warriors.size){ramp_up_time / @warriors.size}
          @warriors.each_with_index { |warrior,index| warrior.attack!('http://localhost/'); sleep(delays[index]); puts 'attacking' }
        end
      else
        @warriors.each { |warrior| warrior.attack!('http://localhost') }
      end
    end

    def kill!
      @warriors.each { |warrior| warrior.kill! }
      @warriors.clear
    end
  end
end
