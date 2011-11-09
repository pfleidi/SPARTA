@squad = Squad.new

@warrior = Warrior.new(
  :provider => :ec2,
  :credentials => {}, #optional ...
  :options => { :ami_id => 'fufufufufu'}
)

@warrior.arm do |weapons|
  weapons.add :apache_benchmark, ....
end

@squad.recruit(@warrior)
@squad.recruit(..)

@squad.engage("http://xerxes.com") do |warrior|
  warrior.fight( .... )
end
