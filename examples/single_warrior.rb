$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "../lib"))

require 'sparta'
include Sparta

warrior = Warrior.new(:provider => :amazonec2)
weapon = Weapon.create(:ApacheBenchmark)
warrior.arm(weapon)
warrior.attack!('http://blog.roothausen.de/', { :requests => 100, :clients => 20 })
warrior.kill!
