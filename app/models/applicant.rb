class Applicant < ApplicationRecord
  belongs_to :user

  before_save :upcase_attributes

  private

  def upcase_attributes
    unupcaseable = ['rating', 'id', 'user_id']
    self.attributes.each do |attribute, value|
      next if !value.is_a?(String) || unupcaseable.include?(attribute)

      value = value.strip.upcase unless value.blank?
      self.send("#{attribute}=", value)
    end
  end
end
