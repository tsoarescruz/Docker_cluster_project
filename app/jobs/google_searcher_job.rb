require './workers/google'

class GoogleSearcherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    results = GoogleWorker.search args.first
    results.each do |result|
      SearchResult.find_or_create result
    end
  end
end
