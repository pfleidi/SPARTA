require 'helper'

class SquadTest < Test::Unit::TestCase

  def setup
    @mock_weapon = mock
    @mock_ssh = mock

    @mock_weapon.stubs(:package_description).returns(
      { 'foo' => 'pwd', 'bar' => 'ls' , 'baz' => 'bar' }
    )
    @mock_weapon.stubs(:test_description).returns('echo testing')
  end

  def test_creating_squad
    squad = Sparta::Squad.new(3, { :provider => :LocalProvider })
    assert_equal 3, squad.warriors.length
  end

  def test_removing_squad
    squad = Sparta::Squad.new(3, { :provider => :LocalProvider })
    squad.kill!
    assert squad.warriors.empty?
  end

  def test_arm_squad
    squad = Sparta::Squad.new(3, { :provider => :LocalProvider })
    squad.arm { @mock_weapon }

    assert_equal false, squad.warriors.collect { |warrior| warrior.is_armed? }.include?(false)
  end

  def test_is_armed
    squad = Sparta::Squad.new(3, { :provider => :LocalProvider })

    squad.arm { @mock_weapon }

    assert squad.is_armed?
  end

  def test_attack
    squad = Sparta::Squad.new(3, { :provider => :LocalProvider })
    @mock_weapon.expects(:usage_description).returns('echo working').at_least_once
    squad.arm { @mock_weapon }
    squad.attack!
  end

  def test_attack_ramp_up
    squad = Sparta::Squad.new(30, { :provider => :LocalProvider })
    @mock_weapon.expects(:usage_description).returns('echo working').at_least_once
    squad.arm { @mock_weapon }
    squad.attack!(:ramp_up => { :period => 10 })
  end
end
