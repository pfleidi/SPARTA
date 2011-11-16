
module ApacheBenchmark

  def setup
    {
      :'apt-get'=> 'apt-get update && apt-get install apache2-utils',
      :pacman => 'pacman -Sy apache',
      :yum => 'init 0'
    }
  end

  def execute(options)    
    "ab -k -n #{options[:requests]} -n #{options[:clients]}"
  end

  def parse(output)
    # return parsed data structure of string output
  end

end
