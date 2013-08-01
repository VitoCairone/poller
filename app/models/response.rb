class Response < ActiveRecord::Base
  attr_accessible :user_id, :choice_id

  belongs_to(:user,
  :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id)

  belongs_to(:choice,
  :class_name => "Choice",
  :foreign_key => :choice_id,
  :primary_key => :id)

  has_one(:question,
  :through => :choices,
  :source => :question)
end
