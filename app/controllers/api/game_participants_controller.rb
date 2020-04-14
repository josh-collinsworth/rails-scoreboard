class Api::GameParticipantsController < ApiController
	def index
		render json: GameParticipant.all
	end

	def show
		render json: GameParticipant.where(game_id: params[:id])
	end

	def create
		@game = Game.find(params[:game_id])
		@participant = Participant.find(params[:participant_id])

		if @game && @participant
			@new_game_participant = GameParticipant.new(game: @game, participant: @participant)

			if @new_game_participant.save
				render json: { success: true }
			else
				render json: { error: true }
			end
		else
			render json: { error: true }
		end
	end

	def update
		@game = GameParticipant.find_by(game_id: params[:id], participant_id: params[:player])
		if @game.update(score: params[:new_score])
			render json: { success: true }
		else
			render json: { error: true }
		end
	end

	def destroy
		@game_participant = GameParticipant.where(game_id: params[:id], participant_id: params[:player_id]).first
		if @game_participant.destroy
			render json: { success: true }
		else
			render json: { error: true }
		end
	end
end

