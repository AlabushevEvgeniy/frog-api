ActiveAdmin.register User do
  permit_params :name, :email, :avatar, :password, :password_confirmation, :remove_image

  index do
    selectable_column
    id_column
    column(:avatar) { |u| image_tag(u.avatar.thumb.url) if u.avatar.url}
    column :name
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :created_at

  show do
    attributes_table do
      row :name
      row :email
      row(:avatar) { |u| image_tag(u.avatar.url) if u.avatar.url}
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :email
      unless f.object.avatar.url.nil?
        f.input :avatar, as: :file, hint: image_tag(f.object.avatar.url)
      else
        f.input :avatar, as: :file
      end
      unless f.object.avatar.nil?
        f.input :remove_image, :as => :boolean
      end
    end
    f.actions
  end

end
