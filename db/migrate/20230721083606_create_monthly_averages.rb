class CreateMonthlyAverages < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_averages do |t|
      t.date :monthly_average_date
      t.string :subject
      t.decimal :monthly_avg_low, precision: 16, scale: 2
      t.decimal :monthly_avg_high, precision: 16, scale: 2
      t.integer :monthly_result_count_used

      t.timestamps
    end
    add_index :monthly_averages, [:subject, :monthly_average_date], unique: true, name: 'idx_on_subject_and_monthly_average_date'
  end
end
