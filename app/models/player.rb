class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :team_id}
end
