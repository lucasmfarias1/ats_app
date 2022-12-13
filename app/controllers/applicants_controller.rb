class ApplicantsController < ApplicationController
  before_action :fetch_or_create_user
  before_action :set_current_user_tags, only: %i[index]
  before_action :set_applicant, only: %i[update show]

  def index
    handle_filters

    @applicants =
      current_user
        .applicants
        .left_joins(:tags)
        .where(tags_are_selected)
        .order(params[:order] || { created_at: :desc })
        .page(params[:page])
        .having(filtered_tags_having_clause)
        .group("applicants.id")
  end

  def create
    @applicant =
      current_user.applicants.create(
        name: params[:name],
        summary: params[:summary],
        rating: params[:rating],
        phone: params[:phone],
        email: params[:email],
        website: params[:website],
        location: params[:location],
        tags:
          processed_tags.map do |tag_name|
            Tag.find_or_initialize_by name: tag_name.strip.upcase,
                                      user: current_user
          end,
      )

    redirect_to root_path
  end

  def update
    add_tag
    remove_tag
    # update_applicant
    render 'update.js.erb'
  end

  def show
  end

  private

  def processed_tags
    params[:tags].split(",")
  end

  def handle_filters
    session[:tags_to_filter] ||= []
    session[:tags_to_filter] |= [params[:add_tag]] if params[:add_tag].present?
    if params[:remove_tag].present?
      session[:tags_to_filter].delete params[:remove_tag]
    end
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

  def add_tag
    return unless params[:add_tag].present?

    @added_tag = Tag.find_or_initialize_by name: params[:add_tag].strip.upcase,
                                    user: current_user

    if @applicant.tags.include? @added_tag
      @added_tag = nil
    else
      @applicant.tags << @added_tag
      @applicant.save
    end
  end

  def remove_tag
    return unless params[:remove_tag].present?

    @removed_tag = @applicant.tags.find_by_name(params[:remove_tag])
    @applicant.tags.destroy(@removed_tag.id) if @removed_tag.present?
  end

  def set_applicant
    @applicant = current_user.applicants.find(params[:id])
  end

  def set_current_user_tags
    @current_user_tags = current_user.tags.joins(:applicants).group("tags.id")
  end
end
