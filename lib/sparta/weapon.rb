module Sparta
  class Weapon
    
    def initialize(name)
      return "foo"
    end
    
    def dependencies 
      {:foo=>'bar'}
    end
    
    def self.create_instance(sym)
      @known_weapons  ||= {}
      clazz = @known_weapons[sym]
      if ( clazz )
        return clazz.new
      end
    end
    
    def self.register(clazz, sym)
      @known_weapons ||= {}
      puts clazz
      @known_weapons[sym] = clazz
    end
    
    def self.load_weapons
      path = "ext/weapons"
      $LOAD_PATH.unshift(path)
      Dir[File.join(path, "*.rb")].each do |bootcamp|
        require File.basename(bootcamp)
      end
    end
    
  end
end