class City < ApplicationRecord
  belongs_to :country
  has_many :trips
  has_many :users, through: :trips
  validates :name, presence: true, uniqueness: true
  validates :country_id, presence: true 

  def country_name=(country_name)
    if country_name[:country] != ""
      country = Country.find_or_create_by(name: country_name[:country])
      self.country_id = country_id
    end
  end

  def rating_avg
    if self.trips.count == 0
      "City has yet to be rated. Please submit your rating to be the first!"
    else
      self.trips.average(:rating).to_f.round(1)
    end
  end

  def combined_name
    "#{self.name}, #{country.name}"
  end

end
