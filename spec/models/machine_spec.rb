require 'rails_helper'

describe Machine, type: :model do
  describe 'validations' do
    it { should validate_presence_of :location }
    it { should belong_to :owner }
    it { should have_many :machine_snacks }
    it { should have_many(:snacks).through(:machine_snacks) }
  end
  describe 'Instance Methods' do
    it '#average_snack_price' do
      owner   = Owner.create!(name: 'Sam')
      machine = owner.machines.create(location: 'Apartment')
      machine.snacks.create(title: 'Candy Bar', price: 1.50)
      machine.snacks.create(title: 'Chips',     price: 1.50)
      machine.snacks.create(title: 'Granola',   price: 2.50)

      expect(machine.average_snack_price.round(2)).to eq(1.83)
    end
  end
end
