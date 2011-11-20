require 'helper'

class BootcampTest < Test::Unit::TestCase
  def setup
    @bootcamp = Sparta::BootCamp.create_instance(:provider => :AmazonEC2,
    :credentials => {:access_id=>'AKIAI46XXH6CP6BDYSOA', :secret_access_key=>'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'}, 
    :options => { :ami_id => 'fufufufufu' })
    
    assert(@bootcamp)
    
    
  end
  
  def test_instance_creation
    assert(@bootcamp.instance_of?(AmazonEC2))
  end
  
  def test_new_warrior
    warrior = @bootcamp.new_warrior
    assert_not_nil(warrior)
    
    assert(warrior.instance_of?(Sparta::Warrior))
  end
  
  def test_can_haz_connection
    @bootcamp.connect!
    assert_not_nil(@bootcamp.connection)
    
    ifconfig = @bootcamp.ssh('ifconfig')
    
    assert_not_nil ( ifconfig)
  end
  
  def test_ssh_working
    
  end
  
  def teardown 
    Sparta::BootCamp.killall
  end

end