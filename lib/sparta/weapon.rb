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

    # returns the result of the test
    def result
      raise "not implemented in base class"
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

    def result_file
      raise "not implemented in base class"
    end

    def create_result
      raise "Not Implemented in base class"
    end

    Weapon.load!
  end
end
