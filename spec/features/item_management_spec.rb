require 'rails_helper'

describe "Item Management", type: :feature, js: true do 
	scenario "User creates a new item" do
		visit items_path

		within("#new_item") do
			fill_in "item[name]", with: "Do the laundry"
		end
		page.execute_script("$('form').submit()")

		expect(page.html).to have_selector(".not-completed", text: "Do the laundry")
	end

	scenario "User marks item as completed" do
		item = Item.create(name: "Do the dishes")
		visit items_path

		click_link "complete-item-#{item.id}"

		expect(page).to have_css(".completed")
	end

	scenario "User deletes item" do
		item = Item.create(name: "Do the dishes")
		visit items_path

		click_link "delete-item-#{item.id}"

		expect(page).to_not have_content("Do the dishes")
	end
end