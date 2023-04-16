class CampaignVolunteer < ApplicationRecord
  belongs_to :campaign
  belongs_to :volunteer
end
