class User < ApplicationRecord
  has_many :trips
  has_many :cities, through: :trips
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  #has_secure_password

  def last_trip
    self.trips.last
  end

  def trip_count
    self.trips.count
  end

end
