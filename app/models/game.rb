class Game < ApplicationRecord
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	has_many :game_participants
	has_many :participants, through: :game_participants
end

