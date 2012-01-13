require 'nokogiri'

class ApacheBenchmark < Sparta::Weapon
  
  def test_description
    "ab -V > /dev/null"
  end
  
  def result_file
    "out.html"
  end
  
  def result
    matching = {"Concurrency Level"=>:concurrency, "Failed requests:"=>:failed_transactions, 
        "Transfer rate:"=>:throughput, "Complete requests:" =>:successful_transactions}
    html = Nokogiri::HTML(@result_contents)
    html.xpath('//th')
  end

  def package_description
    {
      :'apt-get'=> 'sudo bash -c "apt-get update && apt-get install apache2-utils --force-yes --yes"',
      :pacman => 'pacman -Sy apache --noconfirm',
      :yum => 'init 0'
    }
  end
  
  def usage_description(target, options = {})    
    requests = options[:requests]
    clients = options[:clients]
    clients ||= 5
    requests ||= 50

    "ab -w -k -n #{requests} -c #{clients} #{target} > out.html"
  end

  def parse(output)
    raise "not implemented"  
  end

end
