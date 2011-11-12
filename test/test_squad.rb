require 'helper'

class SquadTest < Test::Unit::TestCase

  def setup
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

end
