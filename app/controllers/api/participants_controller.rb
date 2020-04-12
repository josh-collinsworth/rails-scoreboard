class Api::ParticipantsController < ApiController
	def index
		render json: Participant.all
	end

	def create
		@new_participant = Participant.new(name: params[:name])
		if @new_participant.save
			render json: { success: true }
		else
			flash.now[:alert] = "Couldn't create a new player."
		end
	end
end

