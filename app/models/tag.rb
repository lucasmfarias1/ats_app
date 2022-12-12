class Tag < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :applicants

  before_save :cleanup_attributes

  def cleanup_attributes
    self.attributes.each do |attribute, value|
      next unless value.is_a?(String)

      value = value.strip.upcase unless value.blank?
      self.send("#{attribute}=", value)
    end
  end
end
