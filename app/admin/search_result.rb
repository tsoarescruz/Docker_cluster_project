ActiveAdmin.register SearchResult do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  filter :title
  filter :link
  filter :status
  filter :from
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :title do |search_result|
      link_to(search_result.title, search_result.link, target: :blank)
    end
    column :screenshot do |search_result|
      if not search_result.screenshot.url(:thumb).include? 'missing.png'
        link_to(image_tag(search_result.screenshot.url(:thumb)), search_result.link, target: :blank)
      else
        'No image'
      end
    end
    column :link do |search_result|
      search_result.link[0..30]
    end
    column :status
    column :from
    actions
  end

  show do
    attributes_table do
      row :title
      row :link do |link|
        link_to(search_result.title, search_result.link, target: :blank)
      end
      row :status
      row :from
      row :screenshot do |search_result|
        if not search_result.screenshot.url(:medium).include? 'missing.png'
          link_to(image_tag(search_result.screenshot.url(:medium)), search_result.link, target: :blank)
        else
          "No image"
        end
      end
      row :created_at
      row :updated_at
    end
  end

  # Disable admin new action
  actions :all, except: [:new]

  # Custom action search link
  action_item :search, only: :index do
    link_to('Search', search_admin_search_results_path)
  end

  controller do
    def search
      SearchResult.generate_search_queries

      redirect_to admin_search_results_path, notice: 'Search started! Wait a few minutes to see results.'
    end
  end
end
