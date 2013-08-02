class PollerUI

  def initialize
    @user = nil
  end

  def create_poll
    raise "You need to be logged in!" if @user.nil?

    questions = []
    choices = []

    puts "How many questions does your poll have?"
    num_questions = gets.chomp.to_i
    num_questions.times do |i|
      puts "What is question #{i+1}?"
      questions << gets.chomp

      puts "How many answer choices does it have?"
      num_choices = gets.chomp.to_i
      choices << []
      num_choices.times do |j|
        puts "What is answer choice #{j+1}?"
        choices.last << gets.chomp
      end
    end

    poll = Poll.create!({:user_id => @user.id})

    questions.each_with_index do |qstn_text, i|
      question = Question.create!({:body => qstn_text, :poll_id => poll.id})
      choices[i].each do |choice|
        Choice.create!({:choice_text => choice, :question_id => question.id})
      end
    end

  end

  def login(name)
    @user = User.find_by_name(name)
    return if @user.nil?
    puts "Logged in as #{@user.name}"
  end

  def logout
    @user = nil
  end

  def register(name)
    @user = User.create!({:name => name})
  end

  def get_next_poll
    #N+1 Method
    #polls = []
    # Poll.all.each do |poll|
    #   if poll.responders.where("user_id = ?",@user.id).empty?
    #     polls << poll unless poll.user_id == @user.id
    #   end
    # end

    raise "You need to be logged in!" if @user.nil?

    taken_polls = Poll.select("polls.id as poll_id, responses.user_id as rid")
    .joins(:responders)
    .where("rid = ?",@user.id)

    valid_poll_ids  = map_ids(@user.available_polls)
    valid_poll_ids -= taken_polls.map { |poll| poll.poll_id }
    valid_poll_ids -= map_ids(Poll.where("user_id = ?",@user.id))

    if valid_poll_ids.empty?
      puts "There are no polls you have not taken."
      return
    end

    poll = Poll.find(valid_poll_ids.sample)
    questions = Question.where( "poll_id = ?", poll.id)

    questions.each do |question|
      puts question.body
      choices = question.choices

      choices.each do |choice|
        puts "#{choice.id} for #{choice.choice_text}"
      end

      user_choice = gets.chomp.to_i
      c = Choice.find(user_choice)
      if c.nil? || c.question_id != question.id
        raise "Invalid Choice"
      end

      Response.create!({:user_id => @user.id,
                        :choice_id => user_choice})
    end # end of questions.each

    puts "You've completed the poll!"

  end

  private

  def map_ids(poll_arr)
    poll_arr.map { |poll| poll.id }
  end

end















#Poll.select("polls.id as poll_id, responses.user_id as responder_id").joins(:responses)[2].responder__id
#Poll.select("polls.id as poll_id, responses.user_id as responder_id").joins(:responses)[2].responder_id


















