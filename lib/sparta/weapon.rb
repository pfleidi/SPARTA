module Sparta
  class Weapon
    class Result
      attr_accessor :failed_transactions,:successful_transactions
      attr_accessor :concurrency
      attr_accessor :num_requests
      attr_accessor :response_time
      attr_accessor :longest_transaction
      attr_accessor :target
      attr_accessor :throughput # bytes
      
      def merge
        
      end
      
      def merge!
        
      end
    end
    
    def result_file
      raise "not implemented in base class"
    end
    
    def retrieve_results
      @result_contents = @bootcamp.dump_file(result_file)
    end
    
    def create_result
      raise "Not Implemented in base class"
    end
    
    
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

    def install(bootcamp)
      @bootcamp = bootcamp
      provide_packages unless is_working?
    end

    def use(target, options = {})
      @bootcamp.ssh(usage_description(target, options))
    end

    def is_working?
      @bootcamp.ssh(test_description).status == 0
    end

    private

    def provide_packages
      package_description.each do |manager, command|
        result = @bootcamp.ssh(command)
        if result.status == 0
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

