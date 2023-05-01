require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'associations' do
    it { should have_many(:campaign_volunteers).dependent(:destroy) }
    it { should have_many(:volunteers).through(:campaign_volunteers) }
    it { should have_many(:messages).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe '#send_message_to_volunteers' do
    let(:campaign) { create(:campaign) }
    let(:message) { create(:message, campaign: campaign) }
    let(:volunteer1) { instance_double(Volunteer) }
    let(:volunteer2) { instance_double(Volunteer) }

    before do
      allow(volunteer1).to receive(:send_message)
      allow(volunteer2).to receive(:send_message)
      allow(campaign).to receive(:volunteers).and_return([volunteer1, volunteer2])
    end

    it 'sends message to all volunteers associated with the campaign' do
      campaign.send_message_to_volunteers(message.id)
      expect(volunteer1).to have_received(:send_message).with(message.id)
      expect(volunteer2).to have_received(:send_message).with(message.id)
    end
  end
end