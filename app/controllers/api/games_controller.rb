class Api::GamesController < ApiController
	def index
		render json: Game.order(created_at: :desc).all
	end

	def show
		if params[:participants]
			render json: Game.find(params[:id]).participants
		else
			render json: Game.find(params[:id])
		end
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

	def destroy
		@game = Game.find(params[:id])

		GameParticipant.where(game_id: @game.id).each { |gp| gp.destroy }
		if @game.destroy
			render json: { success: true }
		else
			errors = @game.errors.messages[:name].map().join("; ")
			redirect_to game_path(@game), alert: errors
		end
	end

	def go_home
	end
end

