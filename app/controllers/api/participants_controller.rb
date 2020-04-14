class Api::ParticipantsController < ApiController

	def index
		render json: Participant.all.order(name: :asc)
	end

	def create
		@new_participant = Participant.new(name: params[:name])
		if @new_participant.save
			render json: { success: true }
		else
			render json: { error: true }
		end
	end

	def destroy
		@participant = Participant.find(params[:id])
		@games = GameParticipant.where(participant_id: @participant.id)
		unless @games.each { |g| g.delete }
			render json: { error: true }
		end
		if @participant.destroy
			render json: { success: true }
		else
			render json: { error: true }
		end
	end
end

