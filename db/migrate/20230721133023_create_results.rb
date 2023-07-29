class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results_data do |t|
      t.string :subject
      t.datetime :timestamp
      t.decimal :marks, precision: 16, scale: 2

      t.timestamps
    end
  end
end
