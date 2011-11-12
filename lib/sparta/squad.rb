
module Sparta

  class Squad

    def initialize(env = {})
      @warriors = [ ]
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

    def engage_battle(options = {})
      target = options[:with]

      @warriors.each do |warrior|
        warrior.attack(target)
      end
    end

  end
end
