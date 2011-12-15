require 'helper'

class IntegrationTest < Test::Unit::TestCase

  include Sparta

  def test_warrior_and_bootcamp
    warrior = Warrior.new(:provider => :localprovider)
    weapon = Weapon.create(:ApacheBenchmark)
    warrior.arm(weapon)
    warrior.attack!('http://blog.roothausen.de/', { :requests => 100, :clients => 20 })
    warrior.kill!
  end

end
