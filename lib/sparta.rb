
# Rubygems
require 'rubygems'
require 'SecureRandom'

# Internal requires

require 'sparta/squad'
require 'sparta/weapon'
require 'sparta/warrior'
require 'sparta/boot_camp'
require 'sparta/credentials'
require 'sparta/logger'

module Sparta
  VERSION = "0.0.1"
  
  def self.session_uuid
    @session_uuid ||= SecureRandom.uuid
  end
end
