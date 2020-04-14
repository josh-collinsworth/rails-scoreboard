require 'rails_helper'

RSpec.describe Participant, type: :model do
  it "requires players have a name" do
    @new_player = Participant.new(name: "")
    expect { @new_player.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "disallows duplicate player names" do
    @new_participant = Participant.first || Participant.create(name: "Josh")
    @participant_name = @new_participant[:name]

    expect{ Participant.create!(name: @participant_name) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
