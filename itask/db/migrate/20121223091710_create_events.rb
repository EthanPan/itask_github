class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :action, :string
      t.column :operator, :string
      t.column :object, :string

      t.timestamps
    end
  end
end
