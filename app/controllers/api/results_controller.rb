class Api::ResultsController < ApplicationController
  TEST_RESULT_PARAMS = %i[subject timestamp marks].freeze

  def create
    result = Result.new(result_params)

    if result.save
      api_response(::ResultPresenter.new, status: :created)
    else
      api_response(result.errors, status: :unprocessable_entity)
    end
  end

  private

  def result_params
    params[:result].permit(*TEST_RESULT_PARAMS).to_h
  end
end
