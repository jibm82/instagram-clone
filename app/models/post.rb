# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :comments, -> { order(created_at: :desc) }
  has_many :likes, -> { order(created_at: :desc) }
  has_many :photos, dependent: :destroy

  def belongs_to?(user)
    self.user == user
  end

  def liked_by?(user)
    likes.where(user: user).any?
  end

  def bookmarked_by?(user)
    bookmarks.where(user: user).any?
  end
end
