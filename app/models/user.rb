class User < ApplicationRecord
  has_many :applicants
  has_many :tags

  enum tier: [:trial, :free, :premium]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
