class Volunteer < ApplicationRecord
  has_many :campaign_volunteers, dependent: :destroy
  has_many :campaigns, through: :campaign_volunteers
  has_many :messages, through: :campaigns

  validates :name, presence: true
  validates :phone, presence: true

  def send_message(message_id)
    message = messages.find(message_id)
    TwilioService.send_sms(phone, message.text) if message.present?
  end
end
