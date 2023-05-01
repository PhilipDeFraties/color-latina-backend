campaign1 = Campaign.create!(name: "Voting Campaign 2023")
volunteer1 = Volunteer.create!(name: "Phil", phone: "7202768836")
CampaignVolunteer.create!(campaign: campaign1, volunteer: volunteer1)
Message.create!(text: "Don't forget to vote!!!", campaign: campaign1)