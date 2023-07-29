# == Schema Information
#
# Table name: daily_result_stats
#
#  id                     :bigint           not null, primary key
#  daily_result_stat_date :date
#  subject                :string(255)
#  daily_low              :decimal(16, 2)
#  daily_high             :decimal(16, 2)
#  result_count           :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class DailyResultStat < ApplicationRecord
  validates :subject, :daily_low, :daily_high, :daily_result_stat_date, :result_count, presence: true
  validates :subject, uniqueness: { scope: :daily_result_stat_date }
  validates :daily_low, :daily_high, :result_count, numericality: true
end
