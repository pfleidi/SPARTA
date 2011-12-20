require 'helper'

class SquadTest < Test::Unit::TestCase

  def setup
    @mock_weapon = mock
    @mock_ssh = mock

    @mock_weapon.stubs(:install)
    @mock_weapon.stubs(:'is_working?').returns(true)
  end

  def test_creating_squad
    squad = Sparta::Squad.new(3,{:provider => :localprovider})
    assert_equal 3, squad.warriors.length
  end

  def test_creating_squad_failing_warrior
    Sparta::Warrior.stubs(:new).raises(StandardError, 'warrior failed')
    
    assert_raise RuntimeError do
      squad = Sparta::Squad.new(3,{:provider => :localprovider})
    end
  end

  def test_removing_squad
    squad = Sparta::Squad.new(3,{:provider => :localprovider})
    squad.kill!
    assert squad.warriors.empty?
  end

  def test_arm_squad
    squad = Sparta::Squad.new(3,{:provider => :localprovider})
    squad.arm(@mock_weapon)

    assert_equal false, squad.warriors.collect { |w| w.is_armed? }.include?(false)
  end

  def test_is_armed
    squad = Sparta::Squad.new(3,{:provider => :localprovider})

    squad.arm(@mock_weapon)

    assert squad.is_armed?
  end

  def test_attack
    squad = Sparta::Squad.new(3,{:provider => 'localprovider'})
    @mock_weapon.expects(:use).at_least_once
    squad.arm(@mock_weapon)
    squad.attack!
  end

  def test_attack_ramp_up
    squad = Sparta::Squad.new(30,{:provider => 'localprovider'})
    @mock_weapon.expects(:use).at_least_once
    squad.arm(@mock_weapon)
    squad.attack!(:ramp_up => {:period => 10})
  end
end
