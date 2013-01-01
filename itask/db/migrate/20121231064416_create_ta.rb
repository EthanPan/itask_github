class CreateTa < ActiveRecord::Migration
  def change
    create_table :ta do |t|
      t.column :ta
      t.timestamps
    end
  end
end
