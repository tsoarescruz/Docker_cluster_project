require './workers/google'

class GoogleSearcherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    results = GoogleWorker.search args.first
    puts results
  end
end
