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

  def update
    s_params = speaker_params
    s_params[:employer] = Agency.find_by_id s_params[:employer]
    Speaker.update(params[:id], s_params)
    redirect_to speaker_path(Speaker.find_by_id params[:id])
  end

  private

  def speaker_params
    params.require(:speaker).permit(:first_name, :last_name, :job_title, :employer, :bio)
  end

end
