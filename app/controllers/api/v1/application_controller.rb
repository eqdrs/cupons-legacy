require 'application_responder'

class Api::V1::ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :json
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
