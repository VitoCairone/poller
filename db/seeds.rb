# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!({:name => "Vito"})
User.create!({:name => "Nick"})
User.create!({:name => "Ned"})

Poll.create!({:user_id => 1})
Poll.create!({:user_id => 2})
Poll.create!({:user_id => 3})

Question.create!({:poll_id => 1, :body => "Which is the best quark?"})
Question.create!({:poll_id => 2, :body => "Which is the best city?"})
Question.create!({:poll_id => 3, :body => "Which is the best question?"})

quarks = [ "up", "down", "top", "bottom", "strange", "charm" ]
quarks.each{ |quark| Choice.create!({:question_id => 1, :choice_text => quark}) }

cities = [ "New York", "San Francisco", "Chicago", "Paris", "Winnipeg"]
cities.each{ |city| Choice.create!({:question_id => 2, :choice_text => city}) }

Choice.create!({:question_id => 3, :choice_text => "This question"})
Choice.create!({:question_id => 3, :choice_text => "Not this question"})