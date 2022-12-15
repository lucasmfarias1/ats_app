class Applicant < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :notes, dependent: :destroy

  before_save :cleanup_attributes

  private

  def cleanup_attributes
    self.attributes.each do |attribute, value|
      next unless value.is_a?(String)

      value = value.strip.upcase unless value.blank?
      self.send("#{attribute}=", value)
    end
  end
end
