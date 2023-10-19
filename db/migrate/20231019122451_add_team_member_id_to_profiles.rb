class AddTeamMemberIdToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :team_member_id, :integer
    add_foreign_key :profiles, :team_members
  end
end
