ActiveAdmin.register Channel do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :name, tag_ids: []
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  form do |f|
    f.inputs do
      f.input :name
      f.input :tags, input_html: {style: 'width:300px;'}
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :name
    column :tags do |channel|
      channel.tags.all.map{|tag| tag.name}.join(', ')
    end
    column :created_at
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :tags do |channel|
        channel.tags.all.map{|tag| tag.name}.join(', ')
      end
      row :created_at
      row :updated_at
    end
  end

end
