class Campaign < ApplicationRecord
	has_many :campaign_volunteers
	has_many :volunteers, through: :campaign_volunteers
	has_many :messages
end
