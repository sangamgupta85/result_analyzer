# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe DailyResultStat do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:daily_low) }
    it { is_expected.to validate_presence_of(:daily_high) }
    it { is_expected.to validate_presence_of(:daily_result_stat_date) }
    it { is_expected.to validate_presence_of(:result_count) }

    it { is_expected.to validate_numericality_of(:daily_low) }
    it { is_expected.to validate_numericality_of(:daily_high) }
    it { is_expected.to validate_numericality_of(:result_count) }

    it { is_expected.to validate_uniqueness_of(:subject).scoped_to(:daily_result_stat_date) }
  end

  describe 'DailyResultStat object' do
    context 'when an object is valid' do
      it 'saves in database' do
        expect { create(:daily_result_stat) }.to change(described_class, :count).by(1)
      end
    end

    context 'when an object is invalid' do
      it 'does not save and raises an error' do
        expect { create(:daily_result_stat, daily_result_stat_date: nil) }.to raise_error(StandardError)
      end
    end
  end
end
