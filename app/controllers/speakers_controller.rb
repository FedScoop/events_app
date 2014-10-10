class SpeakersController < ApplicationController

  def index
    logged_in? ? @speakers = Speaker.all.order("last_name") : not_logged_in
  end

  def show
    speaker = Speaker.find_by_id(params[:id])
    if logged_in? && speaker
      @speaker = speaker
    elsif !speaker
      flash[:message] = "Sorry, that speaker doesn't exist!"
      redirect_to speakers_path
    else
      not_logged_in
    end
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

  def new
    @speaker = Speaker.new(photo_url: "http://placekitten.com/g/200/200")
  end

  def create
    s_params = speaker_params
    s_params[:employer] = Agency.find_by_id s_params[:employer]
    @speaker = Speaker.new(s_params)
    if @speaker.save
      flash[:message] = "Created #{@speaker.name} successfully!"
      redirect_to speaker_path(@speaker)
    end
  end

  private

  def speaker_params
    params.require(:speaker).permit(:first_name, :last_name, :job_title, :employer, :bio, :photo_url)
  end

end
