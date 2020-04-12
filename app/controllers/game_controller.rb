class GameController < ApplicationController

  def index
	end

	def new
		@game ||= Game.new(name: "")
	end

	def create
		@new_game = Game.new(name: params[:game][:name])

		if @new_game.save
			redirect_to game_path(@new_game.id), notice: "🎲 Enjoy your game!"
		else
			errors = @new_game.errors.messages[:name].map{ |a| a }.join("; ")
			redirect_to new_game_path, alert: errors
		end
	end
end
