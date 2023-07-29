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

FactoryGirl.define do
  factory :monthly_average, class: 'MonthlyAverage' do
    sequence(:subject) { |n| "Subject #{n}" }
    monthly_avg_low { rand(1..500).to_f }
    monthly_avg_high { rand(1..500).to_f }
    monthly_result_count_used { rand(1..500) }
    monthly_average_date { rand(10.days).seconds.from_now }
  end
end
