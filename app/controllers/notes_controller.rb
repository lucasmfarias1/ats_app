class NotesController < ApplicationController
  before_action :set_applicant
  before_action :set_note, only: %i[destroy]

  def create
    @applicant.notes.create(content: params[:content])

    redirect_to applicant_path @applicant
  end

  def destroy
    @note.destroy

    render 'destroy.js.erb'
  end

  private

  def set_applicant
    @applicant = current_user.applicants.find params[:applicant_id]
  end

  def set_note
    @note = @applicant.notes.find params[:id]
  end
end
