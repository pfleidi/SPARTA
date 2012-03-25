module Sparta
  class Barrack < Array
    def each!
      threads = []
      self.each do |e|
        threads << Thread.new do
          yield e
        end
      end

      threads.each { |t| t.join }
    end
  end
end
