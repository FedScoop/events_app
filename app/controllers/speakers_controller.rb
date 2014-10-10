class SpeakersController < ApplicationController

  def index
    logged_in? ? @speakers = Speaker.all.order("last_name") : not_logged_in
  end

end
