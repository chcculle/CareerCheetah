class CreateUserFactors < ActiveRecord::Migration
  def change
    create_table :user_factors do |t|
      t.references :user, index: true
      t.string :name
      t.integer :row_order

      t.timestamps
    end
  end
end

