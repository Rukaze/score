# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Team.create(team_name: "SampleTeam")
team_id = Team.find_by(team_name:"SampleTeam").id
Player.create(name: "ben", team_id: team_id,position: 'G/F')
Player.create(name: "rich", team_id: team_id,position: 'G')
Player.create(name: "haris", team_id: team_id,position: 'F')
Player.create(name: "hoho", team_id: team_id,position: 'F/C')
Player.create(name: "jojo", team_id: team_id,position: 'C')
Player.create(name: "kork", team_id: team_id,position: 'G/F')
5.times do |n|
  Game.create(team: team_id,score: rand(60..80),period_time: 10,opp_name: "enemy#{n+1}",opp_score: rand(60..80))
end
game_id = Game.last.id
5.times do |n|
  Stut.create( player_id: "1", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(7), Deepmiss: rand(7),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 2300, player_name: "ben", team_id: team_id, point: rand(15..25))
end
5.times do |n|
  Stut.create( player_id: "2", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(7), Deepmiss: rand(9),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 1900, player_name: "rich", team_id: team_id, point: rand(10..25))
end
5.times do |n|
  Stut.create( player_id: "3", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(4), Deepmiss: rand(8),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 2000, player_name: "haris", team_id: team_id, point: rand(8..25))
end
5.times do |n|
  Stut.create( player_id: "4", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(7), Deepmiss: rand(7),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 2200, player_name: "hoho", team_id: team_id, point: rand(8..25))
end
5.times do |n|
  Stut.create( player_id: "5", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(4), Deepmiss: rand(11),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 2100, player_name: "jojo", team_id: team_id, point: rand(15..25))
end
5.times do |n|
  Stut.create( player_id: "6", game_id: "#{game_id - n}", FGmake: rand(11), FGmiss: rand(11), Deepmake: rand(6), Deepmiss: rand(10),
  FTmake: rand(11), FTmiss: rand(4), DefReb: rand(11), OffReb: rand(11), Assist: rand(11), Block: rand(5), steal: rand(5),
  TO: rand(5), PF: rand(5), playingtime: 1000, player_name: "kork", team_id: team_id, point: rand(5..25))
end
