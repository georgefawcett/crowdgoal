# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create({first_name: 'George', last_name: 'Fawcett', email: 'georgealanfawcett@gmail.com', password: 'password'})
User.create({first_name: 'Abhi', last_name: 'Muthukumar', email: 'abhi.muthukumar@gmail.com', password: 'password'})

Sport.create(name: 'Soccer', icon: 'soccer')
Sport.create(name: 'Softball / Baseball', icon: 'baseball')
Sport.create(name: 'Hockey (ice)', icon: 'icehockey')
Sport.create(name: 'Hockey (ball)', icon: 'ballhockey')
Sport.create(name: 'Basketball', icon: 'basketball')
Sport.create(name: 'Tennis', icon: 'tennis')
Sport.create(name: 'Frisbee', icon: 'frisbee')
Sport.create(name: 'Volleyball (beach)', icon: 'beachvolleyball')
Sport.create(name: 'Volleyball (court)', icon: 'courtvolleyball')
Sport.create(name: 'Squash', icon: 'squash')
Sport.create(name: 'Golf', icon: 'golf')
Sport.create(name: 'Football', icon: 'football')
Sport.create(name: 'Running / Jogging', icon: 'running')
Sport.create(name: '*Other', icon: 'other')
Sport.create(name: 'Bowling', icon: 'bowling')
Sport.create(name: 'Badminton', icon: 'badminton')
Sport.create(name: 'Ping Pong / Table Tennis', icon: 'pingpong')
Sport.create(name: 'Water Sports', icon: 'watersports')
Sport.create(name: 'Cycling', icon: 'cycling')
