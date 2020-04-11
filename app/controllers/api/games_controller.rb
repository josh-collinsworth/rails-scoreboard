class Api::GamesController < ApiController
	include ActionView::Helpers::DateHelper

	def index
		render json: Game.order(created_at: :desc).all
	end

	def show
		render json: Game.find(params[:id])
	end

	def update
		@new_game = params[:game]
		@game = Game.find(params[:id])
		if @game.nil?
			render json: { errors: ["Not found"], status: :not_found}
		elsif @game.update(name: @new_game[:name], options: @new_game[:options])
			render json: @game
		else
			render json: { errors: @game.errors }, status: :bad_request
		end
	end
end

