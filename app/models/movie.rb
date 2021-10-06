class Movie < ApplicationRecord
  before_save :set_slug
    
  
  #has_many :reviews, dependent: :destroy
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy #this will list reviews most-recent first.
  has_many :critics, through: :reviews, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  validates :title, presence: true, uniqueness: true
  validates :description, length: { minimum: 15 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  RATINGS = %w(G PG PG-13 R NC-17)
  validates :rating, inclusion: { in: RATINGS}


  
  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  #the arrow stands for lambda
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }

  scope :recent, ->(max=5) { released.limit(max) }

  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc) }
      #if using these scopes to replace flops and hits, delete class-level methods first 
  scope :flops, -> { released.where("total_gross < 22500000").order(total_gross: :asc) }

  
  def flop?
      total_gross.blank? || total_gross < 225_000_000
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end
end
