class Api::GameParticipantsController < ApiController
	def index
		render json: GameParticipant.all
	end

	def create
		@game = Game.find(params[:game_id])
		@participant = Participant.find(params[:participant_id])

		if @game && @participant
			@new_game_participant = GameParticipant.new(game: @game, participant: @participant)

			if @new_game_participant.save
				render json: { success: true }
			else
				display_add_participant_error
			end
		else
			display_add_participant_error
		end
	end

	def display_add_participant_error
		render json: { error: true }
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

