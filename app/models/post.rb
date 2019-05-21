# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy

  def belongs_to?(user)
    self.user == user
  end
end
