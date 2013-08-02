class PollAccess < ActiveRecord::Base
  attr_accessible :team_id, :poll_id

  validates :team_id, :presence => true
  validates :poll_id, :presence => true

  belongs_to(:team,
  :class_name => "Team",
  :foreign_key => :team_id,
  :primary_key => :id)

  belongs_to(:poll,
  :class_name => "Poll",
  :foreign_key => :poll_id,
  :primary_key => :id)
end
