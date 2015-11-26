class ApplicationController < ActionController::API
  before_action :authenticate

  private

  attr_reader :current_user
end
