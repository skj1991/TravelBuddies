class User < ApplicationRecord
  has_many :trips
  has_many :cities, through: :trips
  
  has_secure_password
  validates :name, :email, uniqueness: true
  validates :name, :email, presence: true

  def last_trip
    self.trips.last
  end

  def trip_count
    self.trips.count
  end

end
