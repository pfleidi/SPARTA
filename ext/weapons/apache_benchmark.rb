class ApacheBenchmark < Sparta::Weapon
  
  def is_working?
    command_is_available?("ab -V > /dev/null")
  end
  
  def dependencies
    {
      :'apt-get'=> 'apt-get update && apt-get install apache2-utils',
      :pacman => 'pacman -Sy apache',
      :yum => 'init 0'
    }
  end

  def use(target, options={})    
    requests = options[:requests]
    clients = options[:clients]
    clients ||= 5
    requests ||= 50
    @bootcamp.ssh("ab -k -n #{requests} -c #{clients} #{target}")
  end

  def parse(output)
    
    # return parsed data structure of string output
  end
  
  def provide_packages
    
  end

end
Sparta::Weapon.register(ApacheBenchmark, :apache_benchmark)