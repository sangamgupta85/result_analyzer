# == Schema Information
#
# Table name: monthly_averages
#
#  id                        :bigint           not null, primary key
#  monthly_average_date      :date
#  subject                   :string(255)
#  monthly_avg_low           :decimal(16, 2)
#  monthly_avg_high          :decimal(16, 2)
#  monthly_result_count_used :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class MonthlyAverage < ApplicationRecord
  validates :subject, :monthly_avg_low, :monthly_avg_high, :monthly_average_date,
            :monthly_result_count_used, presence: true
  validates :subject, uniqueness: { scope: :monthly_average_date }
  validates :monthly_avg_low, :monthly_avg_high, :monthly_result_count_used, numericality: true
end
