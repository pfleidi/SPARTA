$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "../lib"))

require 'rubygems'
require 'sparta'

squad = Sparta::Squad.new(2 ,{:provider => 'AmazonEC2'})
squad.create_warriors

squad.arm do
  Sparta::Weapon.create(:ApacheBenchmark)
end

squad.attack!("http://www.dhuebner.com/")
squad.report!({:file => "squadoutput"})
squad.kill!
