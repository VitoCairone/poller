class Question < ActiveRecord::Base
  attr_accessible :body, :poll_id

  has_many(:choices,
  :class_name => "Choice",
  :foreign_key => :question_id,
  :primary_key => :id)

  belongs_to(:poll,
  :class_name => "Poll",
  :foreign_key => :poll_id,
  :primary_key => :id)

  has_many(:responses,
  :through => :choices,
  :source => :responses)

  has_many(:responders,
  :through => :responses,
  :source => :user)

  def results
    results = Hash.new(0)
    #choices = self.choices #.where("question_id = ?", self.id)
    choices = self.choices.includes(:responses)
    choices.each do |choice|
      results[choice.choice_text] = choice.responses.length
    end
    results
  end

end
