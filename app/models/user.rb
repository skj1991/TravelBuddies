class User < ApplicationRecord
  has_many :trips
  has_many :cities, through: :trips
  
  has_secure_password
  validates :name, :email, uniqueness: true
  validates :name, :email, presence: true

  def self.new_from_oauth(auth)
      User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = 'password'
      end
  end

  def last_trip
    self.trips.last
  end

  def trip_count
    self.trips.count
  end

end
