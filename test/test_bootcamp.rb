require 'helper'

class BootcampTest < Test::Unit::TestCase
  def setup
    @bootcamp = Sparta::BootCamp.create_instance(:provider => :localprovider)
    
    assert(@bootcamp)
    
    
  end
  
  def test_initializer
    assert_raise do
      Sparta::BootCamp.new
    end
    assert_raise do
      Sparta::BootCamp.new('foo')
    end
    
    assert_raise  do
      Sparta::BootCamp.new('foo', 'bar')
    end
  end
  
  def test_credentials_from_netrc
    bootcamp = Sparta::BootCamp.create_instance(:provider => :AmazonEC2,     :options => { :ami_id => 'fufufufufu' })
    
    assert(bootcamp.credentials)
  end
  
  def test_instance_creation
    assert(@bootcamp.is_a?(Sparta::BootCamp))
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