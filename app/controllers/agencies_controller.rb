class AgenciesController < ApplicationController

  def index
    if_logged_in { @agencies = Agency.all.order "name" }
  end

end
