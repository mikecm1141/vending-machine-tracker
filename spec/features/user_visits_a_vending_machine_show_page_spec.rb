require 'rails_helper'

describe 'As a user' do
  describe 'when I visit /machines/:id' do
    scenario 'I see snacks and their prices for that vending machine' do
      owner   = Owner.create(name: 'Vending Machine Co.')
      machine = owner.machines.create(location: 'Bus Station')
      snack1  = machine.snacks.create(title: 'Chips',   price: 1.50)
      snack2  = machine.snacks.create(title: 'Granola', price: 2.25)

      visit machine_path(machine)

      expect(page).to have_content(snack1.title)
      expect(page).to have_content(snack2.title)
      within("#price-snack-#{snack1.id}") do
        expect(page).to have_content(snack1.price)
      end
      within("#price-snack-#{snack2.id}") do
        expect(page).to have_content(snack2.price)
      end
    end
  end
end
describe 'As a visitor' do
  describe 'when I visit /machines/:id' do
    it 'displays average price for all snacks in that machine' do
      owner   = Owner.create(name: 'Vending Machine Co.')
      machine = owner.machines.create(location: 'Bus Station')
      snack1  = machine.snacks.create(title: 'Chips',   price: 1.50)
      snack2  = machine.snacks.create(title: 'Granola', price: 1.50)
      snack3  = machine.snacks.create(title: 'Cookies', price: 2.50)

      visit machine_path(machine)

      expected_result = machine.average_snack_price

      expect(page).to have_content("Average Snack Price: #{expected_result}")
    end
  end
end
