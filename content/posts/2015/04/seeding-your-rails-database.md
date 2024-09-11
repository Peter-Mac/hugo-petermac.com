---
layout: post
title: "Seeding your rails database"
date: 2015-04-13
categories: 
  - "ruby-on-rails"
---

I’ve been working on a project that requires a good deal of test data to verify functionality. It involves train timetables with many lines, trains, stations etc. To help in uploading data for testing and development I’ve been using the rake db:seed command.

```
rake db:seed RAILS_ENV=development
```

or

```
rake db:seed RAILS_ENV=test
```

For the record I’m using a postgresql database but the use of the seeding implementation is database neutral. It will use the contents of the config/database.yml file to connect to whatever target environment you specify.

One of the problems with loading seed data is when dependencies exist between tables. You need to be able to identify records from table A to be able to create appropriate joins in table B. From a testing perspective there’s fixtures and factories. All well and good and each serves its’ purpose adequately. I wanted to build up a file that can be used to populate a database from scratch with the ability to add new records as your table set grows. I was also able to use it to sanity check my data model and joins as the project continued.

Here’s how the seeding works.

The relevant file is the seeds.rb file in your db folder.

To create single records you won’t need to refer to later in the seeding process, use something like this.

```
#firstly delete any existing data
User.delete_all
#now build up an array
users = [
  {email:'super@test.com', password:'@dmin123', password_confirmation: '@dmin123', admin:true, confirmed_at: '01/01/2011'},
  {email:'user@test.com', password:'user123', password_confirmation: 'user123', confirmed_at: '01/01/2011' }
]

#now process the array using an iterator
users.each { |user| User.create user }
```

To create rows to which you can refer to later on (such as when establishing a table join).

```
Line.delete_all

@frankston_direct_line=Line.create({name:'Frankston Direct'})
@frankston_loop_line=Line.create({name:'Frankston Loop'})
@sandringham_line=Line.create({name:'Sandringham'})
```

You can now refer to id of these records using the syntax @sandringham\_line.id

So now I create a few train stations…

```
Station.delete_all

@aircraft=Station.create(name:'Aircraft' ,latitude:-37.866689 ,longitude:144.760795)
@alamein=Station.create(name:'Alamein' ,latitude: -37.86862  ,longitude: 145.08002)
@altona=Station.create(name:'Altona' ,latitude:-37.867231 ,longitude: 144.829609)
@armadale=Station.create(name:'Armadale', latitude:-37.85544, longitude: 145.018802)

#...
#list cut short for brevity
```

Now I create the association between the lines and stations

LineStation.delete\_all

```
sandringham_line_stations = [
  { line_id: @sandringham_line.id, station_id: @parliament.id, ordinal:1, time:0},
  { line_id: @sandringham_line.id, station_id: @melbourne_central.id, ordinal:2, time:2},
  { line_id: @sandringham_line.id, station_id: @southern_cross.id, ordinal:3, time:3},
  { line_id: @sandringham_line.id, station_id: @flinders_arrival.id, ordinal:4, time:4},

  #...
  #list cut short for brevity
]

#now create all the LineStations iterating over the array
sandringham_line_stations.each { |linestation| LineStation.create linestation }
```

So there you have it. The ability to apply full referential integrity at database seeding time using the power of db:seed.
