class Participant < ApplicationRecord
	has_many :game_participants
	has_many :games, through: :game_participants
	validates :name, presence: true, uniqueness: { case_sensitive: false }
end
