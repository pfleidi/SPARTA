require 'helper'
class WeaponTest < Test::Unit::TestCase
  def test_initializer 
     w =  Sparta::Weapon.new()
    instance = mock
  
  end
  
  def test_instances
    w = Sparta::Weapon.create_instance(:apache_benchmark)
    assert(w)
  end

end