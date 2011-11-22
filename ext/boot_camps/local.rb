
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
    temp_out = StringIO.new
    temp_err = StringIO.new
      old_stdout, $stdout = $stdout, temp_out
      old_stderr, $stderr = $stderr, temp_err
      system(command)
      $stdout = old_stdout 
      $stderr = old_stderr
      actual = temp_out.string
      error = temp_err.string
      [actual,error]
  end
end