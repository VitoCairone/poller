class Poll < ActiveRecord::Base
  attr_accessible :user_id

  has_many(:questions,
  :class_name => "Question",
  :foreign_key => :poll_id,
  :primary_key => :id)

  belongs_to(:user,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id)

  has_many(:responses,
  :through => :questions,
  :source => :responses)

  has_many(:responders,
  :through => :responses,
  :source => :user)

end
