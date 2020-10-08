class ContactResource < ApplicationResource
  attribute :id, :integer, writable: false
  attribute :created_at, :datetime, writable: false
  attribute :updated_at, :datetime, writable: false
  attribute :user_id, :integer
  attribute :name, :string
  attribute :email, :string
  attribute :phone_number, :string

  # Direct associations

  belongs_to :user

  # Indirect associations
end
