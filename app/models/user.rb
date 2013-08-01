class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name

  validates :name, :uniqueness => true

  has_many(:polls,
  :class_name => "Poll",
  :foreign_key => :user_id,
  :primary_key => :id)

  has_many(:responses,
  :class_name => "Response",
  :foreign_key => :user_id,
  :primary_key => :id)

  has_many(:choices,
  :through => :responses,
  :source => :choice)
end