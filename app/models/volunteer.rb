class Volunteer < ApplicationRecord
    has_many :campaign_volunteers
    has_many :campaigns, through: :campaign_volunteers
end
