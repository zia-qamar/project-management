# frozen_string_literal: true

class Project < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  belongs_to :user
  has_many :comments, dependent: :destroy

  enum status: { pending: 0, in_progress: 1, completed: 2 }
end
