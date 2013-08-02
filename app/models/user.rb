class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :team_id

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

  belongs_to(:team,
  :class_name => "Team",
  :foreign_key => :team_id,
  :primary_key => :id)

  has_many(:poll_accesses,
  :through => :team,
  :source => :poll_accesses)

  has_many(:available_polls,
  :through => :poll_accesses,
  :source => :poll)

  def polls_created
    self.polls.includes(:questions).each do |poll|
      question_cnt = poll.questions.length
      puts "#{self.name}'s poll #{poll.id} has #{question_cnt} questions:"
      poll.questions.each do |question|
        puts "  #{question.body}"
        puts "with results: #{question.results}"
      end
      puts "\n"
    end
  end

  def responses_given
    self.responses.includes(:choice => [:question]).each do |response|
      print "You responded to question: #{response.choice.question.body}"
      puts " : #{response.choice.choice_text}"
    end
  end
end


