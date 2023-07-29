# frozen_string_literal: true

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

require 'rails_helper'

RSpec.describe Result do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:timestamp) }
    it { is_expected.to validate_presence_of(:marks) }

    it { is_expected.to validate_numericality_of(:marks) }
  end

  describe 'Result object' do
    context 'when an object is valid' do
      it 'saves in database' do
        expect { create(:result) }.to change(described_class, :count).by(1)
      end
    end

    context 'when an object is invalid' do
      it 'does not save and raises an error' do
        expect { create(:result, timestamp: nil) }.to raise_error(StandardError)
      end
    end
  end
end
