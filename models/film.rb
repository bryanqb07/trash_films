require 'railz_lite'

class Film < RailzLite::SQLObject
  has_many :reviews, foreign_key: :film_id
  def average_rating
    ratings = reviews.map(&:rating)
    return 0 if ratings.empty?
    
    ratings.reduce(:+) / reviews.length
  end
  finalize!
end
