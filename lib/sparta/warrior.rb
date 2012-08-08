require 'rubygems'
require 'timeout'

module Sparta

  class Warrior
    attr_reader :weapon

    def initialize(bootcamp)
      @bootcamp = bootcamp
    end

    def create
      begin
        Timeout::timeout(360) do
          @instance_id = @bootcamp.connect
        end
      rescue => err
        raise "Warrior init failed: #{err.inspect}"
      end
    end

    def arm(weapon)
      @weapon = weapon
      install_weapon
      add_tag
    end

    def is_armed?
      @bootcamp.ssh(@weapon.test_description).status == 0
    end

    def attack(target, options = {})
      raise "need a target!" unless target
      puts @weapon.usage_description(target, options)

      @bootcamp.ssh(@weapon.usage_description(target, options))
    end

    def kill
      @bootcamp.kill!
    end

    def order(command)
      @bootcamp.ssh(command)
    end

    def report
      @result_contents = @bootcamp.dump_file(@weapon.result_file)
      @weapon.parse(@result_contents)
    end

    private

    def add_tag
      if is_armed?
        @bootcamp.add_tag('weapon', @weapon.class.name)
      else
        raise "Tag could not be added because weapon is not working"
      end
    end

    def install_weapon
      @weapon.package_description.each do |manager, command|
        result = @bootcamp.ssh(command)
        if result.status == 0
          if is_armed?
            break
          else
            raise "ERROR: Package installed but still not working. Bailing out."
          end
        end
      end
    end

  end

end
