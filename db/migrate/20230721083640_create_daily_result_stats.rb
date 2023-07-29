class CreateDailyResultStats < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_result_stats do |t|
      t.date :daily_result_stat_date
      t.string :subject
      t.decimal :daily_low, precision: 16, scale: 2
      t.decimal :daily_high, precision: 16, scale: 2
      t.integer :result_count

      t.timestamps
    end
    add_index :daily_result_stats, [:subject, :daily_result_stat_date], unique: true, name: 'idx_on_subject_and_daily_result_stat_date'
  end
end
