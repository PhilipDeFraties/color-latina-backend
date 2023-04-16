class CreateCampaignVolunteers < ActiveRecord::Migration[7.0]
  def change
    create_table :campaign_volunteers do |t|
      t.references :campaign, null: false, foreign_key: true
      t.references :volunteer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
