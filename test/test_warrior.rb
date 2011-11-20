require 'helper'

class WarriorTest < Test::Unit::TestCase
  def setup
    @mock_provider = mock()

    Sparta::BootCamp.boot_camps[:mock] = @mock_provider

    @mock_provider.expects(:create_instance).returns({
      :host => '10.10.10.10',
      :id => '1'
    })
  end

  def test_creating_warrior
    warrior = Sparta::Warrior.new(:boot_camp => :mock)

    assert_equal warrior.instance, {:id => '1', :host => '10.10.10.10'}
  end

  def test_kill_warrior
    warrior = Sparta::Warrior.new(:boot_camp => :mock)

    @mock_provider.expects(:destroy_instance).with({
      :id => warrior.instance[:id],
      :credentials => warrior.credentials
    }).returns(true)

    assert_equal warrior.kill, true
  end
end
