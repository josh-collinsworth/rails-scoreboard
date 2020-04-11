class Game < ApplicationRecord
	validates :name, presence: true
	has_many :participants, through: :participants_in_games
end

