class Campaign < ApplicationRecord
  has_many :campaign_volunteers, dependent: :destroy
  has_many :volunteers, through: :campaign_volunteers
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  def send_message_to_volunteers(message_id)
    volunteers.each do |volunteer|
      volunteer.send_message(message_id)
    end
  end
end
