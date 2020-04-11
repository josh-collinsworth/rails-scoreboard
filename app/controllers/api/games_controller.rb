class Api::GamesController < ApiController
	include ActionView::Helpers::DateHelper

	def index
		render json: Game.order(created_at: :desc).all
	end

	def show
		render json: Game.find(params[:id])
	end
end

