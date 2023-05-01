require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  describe '#send_message' do
    let(:volunteer) { create(:volunteer) }
    let(:campaign) { create(:campaign) }
    let(:message) { create(:message, campaign: campaign) }

    it 'sends message via TwilioService' do
      client = double(Twilio::REST::Client)
      messages = double('Messages')
      allow(client).to receive(:messages).and_return(messages)
      allow(Twilio::REST::Client).to receive(:new).and_return(client)

      expect(messages).to receive(:create).with(
        from: ENV['TWILIO_PHONE_NUMBER'],
        to: volunteer.phone,
        body: message.text
      )

      volunteer.send_message(message.id)
    end
  end
end