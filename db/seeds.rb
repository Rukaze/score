# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Team.create(team_name: "76")
Player.create(name: "ben", team_id: '1',position: 'G/F')
Player.create(name: "rich", team_id: '1',position: 'G')
Player.create(name: "haris", team_id: '1',position: 'F')
Player.create(name: "hoho", team_id: '1',position: 'F/C')
Player.create(name: "jojo", team_id: '1',position: 'C')
Player.create(name: "kork", team_id: '1',position: 'G/F')
