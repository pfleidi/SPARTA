require 'nokogiri'
require 'set'
class ApacheBenchmark < Sparta::Weapon

  def test_description
    "ab -V > /dev/null"
  end

  def result_file
    "out.txt"
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

    "ab -k -n #{requests} -c #{clients} #{target} > out.txt"
  end

  def parse(output)
    results = {}
    results[:concurrency] = Float(/Concurrency Level:\s*(\d+)/.match(output)[1])
    results[:rps] = Float(/Requests per second:\s*(\d+\.{0,1}\d*)/.match(output)[1])
    results[:complete_requests] = Float(/Complete requests:\s*(\d+)/.match(output)[1])
    results[:failed_requests] = Float(/Failed requests:\s*(\d+)/.match(output)[1])

    results
  end

  def merge(data, options={})
    sum_rps = data.inject(0) {|rps, n| rps + n[:rps]}
    sum_concurrency = data.inject(0) {|con, n| con + n[:concurrency]}
    sum_complete = data.inject(0) {|complete, n| complete + n[:complete_requests]}
    sum_failed = data.inject(0) {|failed, n| failed + n[:failed_requests]}

    merged = {
      :concurrency => sum_concurrency, 
      :rps => sum_rps, 
      :complete_requests => sum_complete, 
      :failed_requests => sum_failed
    }

    if options.has_key? :file 

      if not File.exists? options[:file]
        open(options[:file], 'w') do |file|
          file.puts "\"concurrency\",\"completed requests\", \"failed requests\", \"requests per second\""
        end
      end

      open(options[:file], 'a') do |file|
        file.puts "#{merged[:concurrency]},#{merged[:complete_requests]},#{merged[:failed_requests]},#{merged[:rps]}"
      end
    end

    merged
  end
end
