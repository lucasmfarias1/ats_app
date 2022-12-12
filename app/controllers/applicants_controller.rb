class ApplicantsController < ApplicationController
  before_action :fetch_or_create_user

  def index
    @applicants = current_user.applicants
                              .order(params[:order] || { created_at: :desc })
                              .page(params[:page])
  end

  def create
    @applicant = current_user.applicants.create(
      name: params[:name],
      summary: params[:summary],
      rating: params[:rating],
      phone: params[:phone],
      email: params[:email],
      website: params[:website],
      location: params[:location],
      tags: processed_tags.map do |tag_name|
              Tag.find_or_initialize_by name: tag_name, user: current_user
            end
    )

    redirect_to root_path
  end

  private

  def processed_tags
    params[:tags].split(',')
  end
end
