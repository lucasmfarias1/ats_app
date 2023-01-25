class AttachmentsController < ApplicationController
  before_action :set_applicant
  before_action :set_attachment, only: %i[]

  def create
    upload = Cloudinary::Uploader.upload(params[:content], folder: 'ats_app')
    @applicant.attachments.create(
      url: upload["secure_url"],
      filename: params[:content].original_filename,
      json_data: upload.to_json
    )

    redirect_to applicant_path @applicant
  end

  # def destroy
  #   @attachment.destroy

  #   render 'destroy.js.erb'
  # end

  private

  def set_applicant
    @applicant = current_user.applicants.find params[:applicant_id]
  end

  def set_attachment
    @attachment = @applicant.attachments.find params[:id]
  end
end
