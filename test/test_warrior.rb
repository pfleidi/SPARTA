require 'helper'

class WarriorTest < Test::Unit::TestCase
  include Sparta

  def setup
    @weapon = Weapon.create(:ApacheBenchmark)
  end

  def test_init
    bootcamp = mock
    bootcamp.expects(:connect)
    warrior = Warrior.new(bootcamp)
    warrior.create
    assert(warrior.is_a?(Warrior))
  end

  def test_arm
    bootcamp, seq = mock_bootcamp
    
    bootcamp.expects(:ssh).with(@weapon.test_description).returns(
      stub('fakeResult', :status => 0)
    ).in_sequence(seq)

    bootcamp.expects(:add_tag).with('weapon', @weapon.class.name).in_sequence(seq)

    bootcamp.expects(:ssh).with(@weapon.test_description).returns(
      stub('fakeResult', :status => 0)
    ).in_sequence(seq)

    warrior = Warrior.new(bootcamp)
    warrior.create
    warrior.arm(@weapon)
    assert_equal(warrior.weapon, @weapon)
    assert(warrior.is_armed?)
  end

  def test_arm_fail
    bootcamp, seq = mock_bootcamp(stub('fakeResult', :status => 127))
    warrior = Warrior.new(bootcamp)
    warrior.create
    assert_raise(RuntimeError) do
      warrior.arm(@weapon)
    end
  end

  def test_kill
    bootcamp = mock
    seq = sequence('kill sequence')
    bootcamp.expects(:connect).in_sequence(seq)
    bootcamp.expects(:kill!).in_sequence(seq)
    warrior = Warrior.new(bootcamp)
    warrior.create
    warrior.kill
  end

  def test_order
    command = 'testcommand! 234'
    bootcamp = mock
    seq = sequence('order sequence')
    bootcamp.expects(:connect).in_sequence(seq)
    bootcamp.expects(:ssh).with(command).in_sequence(seq)

    warrior = Warrior.new(bootcamp)
    warrior.create
    warrior.order(command)
  end

  private

  def mock_bootcamp(success_return = stub('fakeResult', :status => 0))
    bootcamp = mock
    seq = sequence('loading weapon')
    bootcamp.expects(:connect).in_sequence(seq)

    @weapon.package_description.each do |manager, command|

      if manager == :pacman
        bootcamp.expects(:ssh).with(command).returns(
          stub("fakeResult", :status => 0)
        ).in_sequence(seq)

        bootcamp.expects(:ssh).with(
          @weapon.test_description
        ).returns(success_return).in_sequence(seq)
        break
      else
        bootcamp.expects(:ssh).with(command).returns(
          stub('fakeResult', :status => 127)
        ).in_sequence(seq)
      end
    end

    [bootcamp , seq]
  end



end
