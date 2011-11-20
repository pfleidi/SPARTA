require 'rubygems'
require 'fileutils'
require 'test/unit'
require 'mocha'

World do
  include Test::Unit::Assertions
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'sparta/remote_activity'

def fixture_dir
  File.expand_path File.join(File.dirname(__FILE__), 'support', 'fixtures')
end
