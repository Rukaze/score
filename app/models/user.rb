class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:password_digest] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:password_digest] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password_digest] }
  validates :email, uniqueness: true
  validates :username, uniqueness: true
end
