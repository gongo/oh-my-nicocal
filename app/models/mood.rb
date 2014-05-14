class Mood < ActiveRecord::Base
  before_save { self.name = name.downcase }

  validates :name, :score, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validates :score, numericality: true

  has_many :reports
end
