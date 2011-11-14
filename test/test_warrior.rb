require 'helper'

class WarriorTest < Test::Unit::TestCase
  def setup
    Fog.mock!
    @mock_provider = mock()

    Sparta::Providers.providers[:mock] = @mock_provider

    @mock_provider.expects(:create_instance).returns({
      :host => '10.10.10.10',
      :id => '1'
    })
  end

  def test_creating_warrior
    warrior = Sparta::Warrior.new(:provider => :mock)

    assert_equal warrior.instance, {:id => '1', :host => '10.10.10.10'}
  end

  def test_kill_warrior
    warrior = Sparta::Warrior.new(:provider => :mock)

    @mock_provider.expects(:destroy_instance).with({
      :id => warrior.instance[:id],
      :credentials => warrior.credentials
    }).returns(true)

    assert_equal warrior.kill, true
  end
end
