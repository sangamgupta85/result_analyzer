class Api::ResultsController < ApplicationController
  TEST_RESULT_PARAMS = %i[subject timestamp marks].freeze

  def create
    result = Result.new(result_params)

    if result.save
      render json: { message: 'Submitted successfully' }, status: :created
    else
      render json: result.errors, status: :unprocessable_entity
    end
  end

  private

  def result_params
    params[:result].permit(*TEST_RESULT_PARAMS).to_h
  end
end
