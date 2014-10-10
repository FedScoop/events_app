class SpeakersController < ApplicationController

  def index
    logged_in? ? @speakers = Speaker.all.order("last_name") : not_logged_in
  end

  def show
    logged_in? ? @speaker = Speaker.find_by_id(params[:id]) : not_logged_in
  end

  def edit
    logged_in? ? @speaker = Speaker.find_by_id(params[:id]) : not_logged_in
  end

end
