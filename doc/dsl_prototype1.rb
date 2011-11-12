@squad = Squad.new

@warrior = Warrior.new(
  :provider => :ec2,
  :credentials => {}, #optional ...
  :options => { :ami_id => 'fufufufufu' }
)

@warrior.arm do |weapons|
  weapons.add :apache_benchmark, ....
end

@squad.recruit(@warrior)
@squad.recruit(..)

@squad.add_strategy(:attacks => 100, :concurrent_hits => 20)
@squad.engage_battle(:with => "http://xerxes.com")
