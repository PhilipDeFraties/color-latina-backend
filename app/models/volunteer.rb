require_relative '../services/twilio_service'

class Volunteer < ApplicationRecord
	has_many :campaign_volunteers
	has_many :campaigns, through: :campaign_volunteers

	def send_message(message_id)
		message = Message.find(message_id)
		TwilioService.new.send_sms(phone, message.text)
	end
end
