class SearchController < ApplicationController
  def index
  end

  def create
    GoogleSearcherJob.perform_later params['q']
    render :index
  end
end
