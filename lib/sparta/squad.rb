
module Sparta

  class Squad

    def initialize(env = {})
      @warriors = [ ]
      @strategies = [ ]
    end

    def recruit(warrior)
      @warriors.push(warrior)
    end

    def dismiss(warrior)
      @warriors.delete(warrior)
    end

    def size
      @warriors.size
    end

    def add_strategy(strategy)
      @strategies.push(strategy)
    end

    def engage_battle(options = {}, &block)
      target = options[:with]

      @warriors.each do |warrior|
        @strategies.each do |strategy|
          warrior.attack(target, strategy)
        end

        warrior.attack(target) if @strategies.empty?
      end
    end

  end
end
