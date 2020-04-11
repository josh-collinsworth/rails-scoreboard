class Participant < ApplicationRecord
	has_many :games, through: :participants_in_games
end
