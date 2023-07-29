class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, prepend: true

  private

  def api_response(object, options = nil)
    response_data = { json: object.as_json, location: nil, status: :ok }
    response_data.merge!(options) if options
    render response_data
  end
end
