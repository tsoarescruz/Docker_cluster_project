require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      # Adds Search action for Appointments and Projects
      class Search < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          true
        end

        register_instance_option :collection? do
          true
        end

        register_instance_option :member? do
          false
        end

        register_instance_option :link_icon do
          'icon-search'
        end

        register_instance_option :controller do
          Proc.new do
            SearchResult.generate_search_queries

            redirect_to index_path(model_name: 'search_result'), notice: 'Search started! Wait a few minutes to see results.'
          end
        end
      end
    end
  end
end
