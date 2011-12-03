require 'helper'

class CredentialsTest < Test::Unit::TestCase
  def test_empty_credentials
    credentials = Sparta::Credentials.provide_for_provider('none')
    assert_nil(credentials.login)
    assert_nil(credentials.password)
  end


end