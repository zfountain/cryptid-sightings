class WelcomeController < ApplicationController
  skip_before_filter :require_login, only: [:index, :show]
  def index
    @encounters = Encounter.all
    @cryptids = Cryptid.all
  end
end
