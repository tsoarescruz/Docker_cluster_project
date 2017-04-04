class User < ApplicationRecord
  has_paper_trail

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable

  validates :name, :email, :password, :password_confirmation, presence: true
  validates_confirmation_of :password

  rails_admin do
    list do
      field :name
      field :email
      field :sign_in_count
      field :current_sign_in_at
    end

    edit do
      field :name
      field :email
      field :password
      field :password_confirmation
    end

    show do
      include_all_fields
    end
  end
end
