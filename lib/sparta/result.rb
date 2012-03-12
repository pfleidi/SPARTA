class Result
  attr_accessor :failed_transactions, :successful_transactions
  attr_accessor :concurrency
  attr_accessor :num_requests
  attr_accessor :response_time
  attr_accessor :longest_transaction
  attr_accessor :target
  attr_accessor :throughput # bytes

  def merge

  end

  def merge!

  end
end
