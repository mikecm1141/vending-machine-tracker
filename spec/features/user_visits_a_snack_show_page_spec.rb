# As a visitor
# When I visit a snack show page
# I see the name of that snack
#   and I see the price for that snack
#   and I see a list of locations with vending machines that carry that snack
#   and I see the average price for snacks in those vending machines
#   and I see a count of the different kinds of items in that vending machine.

require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /snacks/:id' do
    scenario 'I see the snack\'s details, where its sold, and machine details' do
      owner1 = Owner.create!(name: 'Greg' )
      owner2 = Owner.create!(name: 'Susan')

      machine1 = owner1.machines.create!(location: 'Greg\'s Basement')
      machine2 = owner2.machines.create!(location: 'Susan\'s Store'  )

      snack1 = Snack.create!(title: 'Candy Bar', price: 2.50)
      snack2 = Snack.create!(title: 'Chips',     price: 1.60)

      machine1.snacks << [snack1, snack2]
      machine2.snacks << [snack1, snack2]

      visit snack_path(snack1)

      expect(page).to have_content(snack1.title)
      expect(page).to have_content("Price: $#{snack1.price}")
      expect(page).to have_content(machine1.location)
      within("#machine-#{machine1.id}") do
        expect(page).to have_content("#{machine1.snacks.count} kinds of snacks")
        expect(page).to have_content("average price of #{machine1.average_snack_price}")
      end
      expect(page).to have_content(machine2.location)
      within("#machine-#{machine2.id}") do
        expect(page).to have_content("#{machine2.snacks.count} kinds of snacks")
        expect(page).to have_content("average price of #{machine2.average_snack_price}")
      end
    end
  end
end
