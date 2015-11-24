class Link < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :url, presence: true
  validates :category, presence: true
end
