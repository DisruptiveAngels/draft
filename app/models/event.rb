class Event < ApplicationRecord
  before_create :generate_slug
  has_many :invitations
  has_many :attendees
  has_many :teams
  has_many :users, through: :attendees
  has_many :invited_users, through: :invitations, class_name: 'User', source: :user
  attachment :image

  def to_param
    slug
  end

  def self.find(input)
    if input.is_a?(Integer)
      super
    else
      find_by(slug: input)
    end
  end

  private

  def generate_slug
    self.slug = name.parameterize
  end
end
