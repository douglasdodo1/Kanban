class Task < ApplicationRecord
  validates :tittle, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end
