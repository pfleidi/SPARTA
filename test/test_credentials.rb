require 'helper'

class CredentialsTest < Test::Unit::TestCase
  def test_empty_credentials
    credentials = Sparta::Credentials.provide_for_provider('none')
    assert_nil(credentials.login)
    assert_nil(credentials.password)
  end
  
  def test_filled_credentials 
    credentials = Sparta::Credentials.provide_for_provider('amazonec2')
    assert(credentials.login)
    assert(credentials.password)
    
  end

end