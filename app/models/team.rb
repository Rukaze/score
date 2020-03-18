class Team < ApplicationRecord
  validates :team_name, presence: true, uniqueness: { case_sensitive:  false }
end
