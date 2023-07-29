# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResultPresenter do
  describe '#present' do
    subject { described_class.new.present }

    let(:expected_response) { { message: 'Submitted successfully' } }

    context 'when test result is successfully saved' do
      it 'returns successful json response' do
        expect(subject).to eq(expected_response)
      end
    end
  end
end
