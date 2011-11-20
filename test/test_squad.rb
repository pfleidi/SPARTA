require_relative './helper'

class SquadTest < Test::Unit::TestCase

  def setup
    @enemy = "http://xerxes.com"
    @squad = Sparta::Squad.new
  end

  def test_adding_warrior
    assert_equal(@squad.size, 0)
    5.times { @squad.recruit(mock) }
    assert_equal(@squad.size, 5)
  end

  def test_removing_warrior
    assert_equal(@squad.size, 0)
    @squad.recruit(mock)
    warrior = mock
    @squad.recruit(warrior)
    assert_equal(@squad.size, 2)
    @squad.dismiss(warrior)
    assert_equal(@squad.size, 1)
  end

  def test_engage_normal_battle
    5.times do
      warrior = mock
      warrior.expects(:attack).with(@enemy).once
      @squad.recruit(warrior)
    end

    @squad.engage_battle(:with => @enemy) 
  end

  def test_engage_strategic_battle
    opts = { :attack => 100, :concurrent_hits => 20 }

    3.times do
      warrior = mock
      warrior.expects(:attack).with(@enemy, opts).once
      @squad.recruit(warrior)
    end

    @squad.add_strategy(opts)
    @squad.engage_battle(:with => @enemy) 
  end

  def test_engage_multi_strategy_battle
    opts1 = { :attack => 100, :concurrent_hits => 20 }
    opts2 = { :attack => 500, :concurrent_hits => 40 }
    battle = sequence('really hard battle')

    4.times do
      warrior = mock
      warrior.expects(:attack).with(@enemy, opts1).in_sequence(battle)
      warrior.expects(:attack).with(@enemy, opts2).in_sequence(battle)
      @squad.recruit(warrior)
    end

    @squad.add_strategy(opts1)
    @squad.add_strategy(opts2)
    @squad.engage_battle(:with => @enemy) 
  end


end
