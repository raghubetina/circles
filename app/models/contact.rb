# == Schema Information
#
# Table name: contacts
#
#  id           :integer          not null, primary key
#  email        :string
#  name         :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_contacts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Contact < ApplicationRecord
  # Direct associations

  belongs_to :user,
             counter_cache: true

  # Indirect associations

  # Validations

  validates :email, uniqueness: { scope: [:user_id, :email] }, presence: true

  # Scopes

  def to_s
    name.present? ? "#{name} <#{email}>" : email
  end

  before_validation :normalize_email
 
  def normalize_email
    self.email = email.downcase
  end
end
