class CreateSnacks < ActiveRecord::Migration[5.1]
  def change
    create_table :snacks do |t|
      t.string :title
      t.float :price

      t.timestamps
    end
  end
end
