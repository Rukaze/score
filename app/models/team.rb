class Team < ApplicationRecord
  validates :team_name, presence: true, uniqueness: true
end
