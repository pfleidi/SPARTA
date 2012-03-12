require 'helper'

class WeaponTest < Test::Unit::TestCase
  include Sparta

  def setup
    @weapon = Weapon.create(:ApacheBenchmark)
  end

  def test_load_weapons
    assert(Weapon.weapons.length > 0)
  end

  def test_create
    assert(@weapon.kind_of?(Weapon))
    assert(@weapon.instance_of?(ApacheBenchmark))
  end

  def test_creation_fail
    assert_raise(RuntimeError) do
      @weapon = Weapon.create(:WeaponDoesNotExist)
    end
  end
 
end
