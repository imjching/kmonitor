class CreateProgressEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :progress_entries do |t|
      t.integer :rank
      t.decimal :score, precision: 15, scale: 1
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
