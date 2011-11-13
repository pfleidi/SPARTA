module Sparta
  class Warrior
    def initialize(env = {})
      @provider = env[:provider]
      @credentials = env[:credentials]
      @id = Providers.providers[@provider].create_instance(env)
    end

    def kill(env = {})
      Providers.providers[@provider].destroy_instance(:id => @id, :credentials => env[:credentials])
    end

    def arm

    end

    def fight

    end
  end
end
