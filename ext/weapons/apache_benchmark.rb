class ApacheBenchmark < Sparta::Weapon
  
  def test_description
    "ab -V > /dev/null"
  end

  def package_description
    {
      :'apt-get'=> 'apt-get update && apt-get install apache2-utils',
      :pacman => 'pacman -Sy apache',
      :yum => 'init 0'
    }
  end
  
  def usage_description(target, options = {})    
    requests = options[:requests]
    clients = options[:clients]
    clients ||= 5
    requests ||= 50

    "ab -k -n #{requests} -c #{clients} #{target}"
  end

  def parse(output)
    raise "not implemented"  
  end

end
