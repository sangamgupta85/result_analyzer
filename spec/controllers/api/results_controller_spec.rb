# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ResultsController, type: :controller do
  describe '#create' do
    let(:post_call) { post :create, params: { result: attributes } }

    context 'when mandatory attributes are present' do
      let(:attributes) do
        {
          subject: 'Science',
          timestamp: '2023-07-26 16:26:29.15896',
          marks: 120.5
        }
      end

      it 'creates a new test result' do
        expect { post_call }.to change(Result, :count).by(1)
      end

      it 'returns 201 http status' do
        post_call
        expect(response).to have_http_status(:created)
      end
    end

    context 'when one of the mandatory attribute is not present' do
      let(:attributes) do
        {
          subject: 'Science',
          marks: 120.5
        }
      end

      it 'does not create a new test result' do
        expect { post_call }.not_to change(Result, :count)
      end

      it 'returns 422 http status' do
        post_call
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
