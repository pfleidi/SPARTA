require "fog"

class LocalProvider < Sparta::BootCamp

  def initialize(credentials, options)
    #noop
  end

  def connection
    return "no connection.."
  end

  def connect!

  end

  def ssh(command)
    # some redirection here..
    actual = `#{command}`
    result = Fog::SSH::Result.new(command)
    result.stdout = actual
    result.status = 0

    result
  end

  def kill!

  end
end
