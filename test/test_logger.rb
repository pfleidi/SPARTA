require 'helper'

class LoggerTest < Test::Unit::TestCase
  include Sparta
  def test_logger
    Logger.log("foo")
    Logger.log("foo",Logger::INFO)
    Logger.log("foo", Logger::INFO, self)
  end
end