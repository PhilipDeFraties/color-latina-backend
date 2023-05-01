class Message < ApplicationRecord
  belongs_to :campaign

  validates :text, presence: true
  validates :campaign, presence: true
end
