require 'helper'

class IntegrationTest < Test::Unit::TestCase
  def test_warrior_and_bootcamp
    bootcamp = Sparta::BootCamp.create_instance(:provider => :localprovider)
    assert(bootcamp)
    warrior = Sparta::Warrior.new(bootcamp)
    weapon = Sparta::Weapon.create_instance(:apache_benchmark)
    assert(warrior)
    warrior.target = 'http://www.google.de/'
    assert(weapon)
    warrior.arm(weapon)
    warrior.attack!
  end

end