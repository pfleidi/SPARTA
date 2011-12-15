module Sparta
  class Weapon

    def self.create(weapon_name)
      clazz = weapons[weapon_name]

      if clazz.nil?
        raise "Weapon #{weapon_name} does not exist!"
      else 
        return clazz.new()
      end
    end

    def self.weapons
      @weapons ||= {}
    end

    def self.inherited(child)
      weapon_name = child.name.to_s.to_sym
      self.weapons[weapon_name] = child
    end

    def self.load!
      path = "ext/weapons"
      $LOAD_PATH.unshift(path)
      Dir[File.join(path, "*.rb")].each do |weapon|
        require File.basename(weapon)
      end
    end

    def install(bootcamp)
      @bootcamp = bootcamp
      provide_packages unless is_working?
    end

    def use(target, options = {})
      @bootcamp.ssh(usage_description(target, options))
    end

    def is_working?
      not @bootcamp.ssh(test_description).nil?
    end
    
    private

    def provide_packages
      package_description.each do |manager, command|
        if @bootcamp.ssh(command)
          if is_working?
            break
          else
            raise "ERROR: Package installed but still not working. Bailing out."
          end
        end
      end
    end
  end

  Weapon.load!
end

