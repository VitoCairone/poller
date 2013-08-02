class Team < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many(:members,
  :class_name => "User",
  :foreign_key => :team_id,
  :primary_key => :id)

  has_many(:poll_accesses,
  :class_name => "PollAccess",
  :foreign_key => :team_id,
  :primary_key => :id)

  has_many(:available_polls,
  :through => :poll_accesses,
  :source => :poll)

end
