require Rails.root.join('workers', 'google.rb')

class GoogleSearcherJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GoogleWorker.search args.first
  end
end
