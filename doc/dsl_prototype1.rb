#@squad = Squad.new

# valid credentials
# :credentials = { :aws_secret => ..., :aws_id => ... }
# if there is no keyfile specifiec, keys will be created.

@bootcamp = Sparta::BootCamp.new(
:provider => :ec2,
:credentials => {}, 
:options => { :ami_id => 'fufufufufu' }
)

@warrior = @bootcamp.new_warrior
@warrior.arm(Weapon.new(:apache_benchmark))

@warrior.attack!(:target => 'heise.de', {:intensity=>500, :ramp_up=>50})

csv = @warrior.collect_results

#@squad.recruit(@warrior)
#@squad.recruit(..)#

#@squad.add_strategy(:attacks => 100, :concurrent_hits => 20)
#@squad.engage_battle(:with => "http://xerxes.com")
