require 'rails_helper'

RSpec.describe Event, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "is presence" do
    event = Event.new
    event.name = ""
    expect(event).not_to be_valid
  end

  it "is unique" do
    event2 = Event.new
    event2.name = "ランニング"
    event3 = Event.new
    event3.name = "ランニング"
    expect(event3).not_to be_valid
  end
end
