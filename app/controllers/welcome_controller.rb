class WelcomeController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  def index
  end
end
