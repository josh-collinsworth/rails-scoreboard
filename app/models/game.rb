class Game < ApplicationRecord
	validates :name, presence: true
	has_many :game_participants
	has_many :participants, through: :game_participants
end

