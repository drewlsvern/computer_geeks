# encoding: UTF-8
#
ActiveAdmin.register User do

  config.sort_order = 'first_name asc'

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    column :updated_at
    default_actions
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :list, :of, :attributes, :on, :model, :first_name, :last_name, :password,
                :password_confirmation, :email, :email_confirmation
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  form do |f|
    f.inputs 'New User Details' do
      f.input :first_name
      f.input :last_name
      f.input :default_ship, as: :select, collection: Address.where("user_id = " + user.id.to_s)
      f.input :default_bill, as: :select, collection: Address.where("user_id = " + user.id.to_s)
      if f.object.new_record?
        f.input :password, label: 'Password:'
        f.input :password_confirmation, label: 'Password Confirmation:'
      end
      f.input :email
      f.input :email_confirmation
    end
    f.actions
  end
end
