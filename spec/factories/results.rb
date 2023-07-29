# == Schema Information
#
# Table name: results_data
#
#  id         :bigint           not null, primary key
#  subject    :string(255)
#  timestamp  :datetime
#  marks      :decimal(16, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :result, class: 'Result' do
    sequence(:subject) { |n| "Subject #{n}" }
    timestamp { rand(10.days).seconds.from_now }
    marks { rand(1..500).to_f }
  end
end
