require 'helper'
class WeaponTest < Test::Unit::TestCase

def _basic
  weapon = Sparta::Weapon.create_instance(:apache_benchmark)
  assert_not_nil(weapon)
  
  config = weapon.dependencies
  assert(config.instance_of?(Hash))
  
  
end

end