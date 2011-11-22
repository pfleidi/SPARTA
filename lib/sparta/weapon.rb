module Sparta
  class Weapon
    
    def initialize()
    end
    
    def dependencies 
      {:foo=>'bar'}
    end
    
    def self.create_instance(sym)
      @known_weapons  ||= {}
      clazz = @known_weapons[sym]
      if ( clazz )
        return clazz.new()
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
    
    
    def is_working?
      false
    end
    
    def command_is_available?(cmd)
      @bootcamp.ssh(cmd)
    end
    
    def install(instance)
      @bootcamp = instance
      if ( is_working? )
        puts "already working."
      else
        provide_packages
      end
    end
    
    def provide_packages
      @instance ||= nil
      raise 'Need an instance here.' unless @instance
      deps = self.dependencies
      deps.each do |manager, command|
        if ( @instance.ssh(command) )
          puts "packet manager #{manager} worked. installed packages."
          break
        end
      end
    end
    
    
    
  end
end
Sparta::Weapon.load_weapons