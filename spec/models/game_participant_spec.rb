require 'rails_helper'

RSpec.describe GameParticipant, type: :model do
  it "prevents one player from entering a game multiple times" do
    @new_game = Game.create(name: "mxzylptq")
    @new_participant = Participant.create(name: "Hyde")
    @entry = GameParticipant.create(game_id: @new_game.id, participant_id: @new_participant.id)
    @dupe = GameParticipant.new(game_id: @new_game.id, participant_id: @new_participant.id)
    expect{ @dupe.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
