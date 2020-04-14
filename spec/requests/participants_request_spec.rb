require 'rails_helper'

RSpec.describe "participants", type: :request do
	describe "delete /api/participants/:id" do
		it "deletes a participant successfully" do
			@participant = Participant.create!(name: "chump")
			delete "/api/participants/#{@participant.id}"
			expect(response).to be_successful
			expect(Participant.find_by(id: @participant.id)).to be_nil
		end
	end

	describe "get /api/participants" do
		it "retrieves all participants successfully" do
			@p1 = Participant.create!(name: "chump")
			@p2 = Participant.create!(name: "chumpette")
			get "/api/participants"
			@json = JSON.parse(response.body)
			@all_participants = Participant.all
			expect(response).to be_successful
			expect(@json.count).to eq(@all_participants.count)
			expect(@json.count).to eq(2)
		end
	end
end
