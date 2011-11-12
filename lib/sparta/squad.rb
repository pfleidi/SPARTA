
module Sparta

  class Squad
    include Enumerable

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

    def each(&block)
      @warriors.each { |warrior| block.call(warrior) }
    end

  end

end
