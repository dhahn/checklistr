require "rails_helper"

RSpec.describe Item, :type => :model do
	let(:item) { Item.new(name: "Let's do this") }

	it "must have a name" do
		item.name = nil
		expect(item.valid?).to eq(false)
	end

	describe "completed?" do
		describe "when completed_at is nil" do
			it { expect(item.completed?).to eq(false) }
		end

		describe "when completed_at is has a value" do
			before { item.completed_at = Time.now }
			it { expect(item.completed?).to eq(true) }
		end
	end
end   
