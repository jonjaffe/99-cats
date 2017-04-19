class Cat < ApplicationRecord
  COLORS = ["red", "black", "white", "fuschia"]

  validates :birth_date, :name, :description, presence: true
  validates :color, inclusion: { in: self::COLORS }
  validates :sex, presence: true, inclusion: { in: ['M', 'F'] }

  def age
    today = Date.today
    d = Date.new(today.year, birth_date.month, birth_date.day)
    d.year - birth_date.year - (d > today ? 1 : 0)
  end

  has_many :rental_requests,
  primary_key: :id,
  foreign_key: :cat_id,
  class_name: :CatRentalRequest,
  dependent: :destroy

end
