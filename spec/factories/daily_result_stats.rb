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

FactoryGirl.define do
  factory :daily_result_stat, class: 'DailyResultStat' do
    sequence(:subject) { |n| "Subject #{n}" }
    daily_low { rand(1..500).to_f }
    daily_high { rand(1..500).to_f }
    result_count { rand(1..100) }
    daily_result_stat_date { rand(10.days).seconds.from_now }
  end
end
