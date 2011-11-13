module Sparta
  module Credentials
    def self.providers
      @providers ||= {}
    end
  end
end
