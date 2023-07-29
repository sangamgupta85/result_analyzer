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

class Result < ApplicationRecord
  self.table_name = :results_data

  validates :subject, :timestamp, :marks, presence: true
  validates :marks, numericality: true
end
