module Sparta
  class Logger
    INFO = 1
    DEBUG = 2
    WARNING = 3
    SEVERE = 4
    OMGERROR = 5
    def self.log(message, level=Logger::INFO, instance=nil)
      puts "#{Time.now()}\t:#{instance.class}\t:#{level}:#{message}"
    end
    
  end
end