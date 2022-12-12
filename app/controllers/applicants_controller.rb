class ApplicantsController < ApplicationController
  before_action :fetch_or_create_user

  def index
    handle_filters

    @applicants = current_user.applicants
                              .joins(:tags)
                              .where(tags_are_selected)
                              .order(params[:order] || { created_at: :desc })
                              .page(params[:page])
                              .having(filtered_tags_having_clause)
                              .group('applicants.id')
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
              Tag.find_or_initialize_by name: tag_name.strip.upcase, user: current_user
            end
    )

    redirect_to root_path
  end

  private

  def processed_tags
    params[:tags].split(',')
  end

  def handle_filters
    session[:tags_to_filter] ||= []
    session[:tags_to_filter] |= [params[:add_tag]] if params[:add_tag].present?
    session[:tags_to_filter].delete params[:remove_tag] if params[:remove_tag].present?
    session[:tags_to_filter].compact!
  end

  def tags_are_selected
    return unless session[:tags_to_filter].present?

    { tags: { name: session[:tags_to_filter] } }
  end

  def filtered_tags_having_clause
    return unless session[:tags_to_filter].present?

    "COUNT(DISTINCT tags.name) = #{session[:tags_to_filter].count}"
  end
end
