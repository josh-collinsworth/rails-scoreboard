require 'rails_helper'

RSpec.describe Game, type: :model do
  it "checks uniqueness in game names" do
    @name = "ALSKDJFHG1029384756"
    @game = Game.create(name: @name)
    @dupe = Game.new(name: @name)
    expect{ @dupe.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "has the default options hash" do
    @game = Game.new(name: "New game title")
    expect(@game.options).to eq({"increment"=>1,"include_increment_by_one"=>false,"call_players"=>true,"prepend"=>"","append"=>"","add_reset"=>false,"add_double"=>false,"add_halve"=>false})
  end
end
