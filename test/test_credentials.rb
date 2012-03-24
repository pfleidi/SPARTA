require 'helper'

class CredentialsTest < Test::Unit::TestCase

  def test_aws_credentials
      credentials = Sparta::Credentials.provide_for_provider('AmazonEC2')
      assert(credentials.login, 'a_id')
      assert(credentials.password, 'a_password')
  end

  def test_empty_credentials
    assert_raise do
      credentials = Sparta::Credentials.provide_for_provider('none')
    end
  end

end
