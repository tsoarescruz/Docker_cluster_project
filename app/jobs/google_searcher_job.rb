require './workers/google'

class GoogleSearcherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GoogleWorker.search args.first
  end
end
