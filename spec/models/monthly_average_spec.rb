# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe MonthlyAverage do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:monthly_avg_low) }
    it { is_expected.to validate_presence_of(:monthly_avg_high) }
    it { is_expected.to validate_presence_of(:monthly_average_date) }
    it { is_expected.to validate_presence_of(:monthly_result_count_used) }

    it { is_expected.to validate_numericality_of(:monthly_avg_low) }
    it { is_expected.to validate_numericality_of(:monthly_avg_high) }
    it { is_expected.to validate_numericality_of(:monthly_result_count_used) }

    it { is_expected.to validate_uniqueness_of(:subject).scoped_to(:monthly_average_date) }
  end

  describe 'MonthlyAverage object' do
    context 'when an object is valid' do
      it 'saves in database' do
        expect { create(:monthly_average) }.to change(described_class, :count).by(1)
      end
    end

    context 'when an object is invalid' do
      it 'does not save and raises an error' do
        expect { create(:monthly_average, monthly_average_date: nil) }.to raise_error(StandardError)
      end
    end
  end
end
