class Gear < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true
  has_many :bookings, dependent: :destroy
  has_one_attached :photo
end
