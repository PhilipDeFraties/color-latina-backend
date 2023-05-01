class CampaignVolunteer < ApplicationRecord
  belongs_to :campaign
  belongs_to :volunteer

  validates :campaign, presence: true
  validates :volunteer, presence: true
end
