require "fog"
require "open3"

class LocalProvider < Sparta::BootCamp

  def initialize(credentials, options)
    #noop
  end

  def connection
    return "no connection.."
  end

  def connect!

  end

  def add_tag(key, value)

  end

  def ssh(command)
    result = Fog::SSH::Result.new(command)

    stdin, stdout, stderr = Open3.popen3(command)
    result.stdout = stdout.readlines.join("")
    result.stderr = stderr.readlines.join("")
    result.status = $?.to_i

    result
  end

  def kill!

  end
end
