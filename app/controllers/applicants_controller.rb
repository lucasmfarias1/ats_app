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
      location: params[:location]
    )

    redirect_to root_path
  end
end
