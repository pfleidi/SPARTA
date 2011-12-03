require 'helper'

class IntegrationTest < Test::Unit::TestCase

  include Sparta

  def test_warrior_and_bootcamp
    warrior = Warrior.new(:provider => :localprovider)
    weapon = Weapon.create_instance(:apache_benchmark)
    warrior.arm(weapon)
    warrior.attack!('http://www.google.de/', { :requests => 100, :clients => 20 })
  end

end
