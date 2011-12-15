require './lib/sparta/warrior'

module Sparta
  class Squad
    attr_reader :warriors

    def initialize(count, env = {})
      @warriors = []

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

    def attack!
      @warrior.each { |warrior| warrior.attack! }
    end

    def kill!
      @warriors.each { |warrior| warrior.kill! }
      @warriors.clear
    end
  end
end
