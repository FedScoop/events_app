class SpeakersController < ApplicationController

  def index
    if_logged_in { @speakers = Speaker.all.order("last_name") }
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
    if_logged_in { @speaker = Speaker.find_by_id(params[:id]) }
  end

  def update
    speaker = Speaker.find_by_id params[:id]
    s_params = speaker_params
    s_params[:employer] = Agency.find_by_id s_params[:employer]
    if Speaker.update speaker.id, s_params
      Delayed::Worker.new.work_off
      if params[:remove_photo]
        speaker.photo = nil
        speaker.save!
      end
      flash[:message] = speaker.name + " updated successfully!"
      redirect_to speaker_path(speaker)
    else
      flash[:message] = "Oops, something went wrong"
      redirect_to edit_speaker_path(speaker)
    end
  end

  def new
    if_logged_in { @speaker = Speaker.new }
  end

  def create
    s_params = speaker_params
    s_params[:employer] = Agency.find_by_id s_params[:employer]
    @speaker = Speaker.new(s_params)
    if @speaker.save
      Delayed::Worker.new.work_off
      flash[:message] = "Created #{@speaker.name} successfully!"
      redirect_to speaker_path(@speaker)
    else
      flash[:message] = "Oops, something went wrong"
      redirect_to new_speaker_path
    end
  end

  def destroy
    @speaker = Speaker.find_by_id params[:id]
    speaker_name = @speaker.name
    if @speaker.destroy!
      flash[:message] = "#{speaker_name} successfully deleted"
      redirect_to speakers_path
    else
      flash[:message] = "An error occurred."
      redirect_to speaker_path(@speaker)
    end
  end

  private

  def speaker_params
    params.require(:speaker).permit(:first_name, :last_name, :job_title, :employer, :bio, :photo)
  end

end
