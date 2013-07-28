# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.delete_all
Course.delete_all
Area.delete_all
User.delete_all
Description.delete_all
Role.delete_all

roles = Role.create([
  {name: 'Administrador'},
  {name: 'Universidade'},
  {name: 'Professor'},
  {name: 'Aluno'},
])


descriptions = Description.create([
  {:address => 'Rua de Adm', :information => 'Administrador', :name => 'Paulo Cesar', :phone => '1234-1234'},
  {:address => 'Rua do Professor', :information => 'Curriculo Professor', :name => 'Joao Torres', :phone => '1234-1234'},
  {:address => 'Rua do Aluno', :information => 'Curriculo Aluno', :name => 'Felipe Bastos', :phone => '1234-1234'}
])

users = User.create([
  {
    :email => "pauloc062@gmail.com",
    :role => roles.first,
    :password => "exemplo",
    :password_confirmation => "exemplo",
    :description => descriptions[0]
  },
  {
    :email => "joaotorresdantas@gmail.com",
    :role => roles[2],
    :password => "exemplo",
    :password_confirmation => "exemplo",
    :description => descriptions[1]
  },
  {
    :email => "fsbastos@gmail.com",
    :role => roles[3],
    :password => "exemplo",
    :password_confirmation => "exemplo",
    :description => descriptions[2]
  }
])

users.first.friends << users[1]

areas = Area.create([
  {:name => "Administracao"},
  {:name => "Matematica"}
])

courses = Course.create([
  {:name => 'Negociacao', :information => 'Curso de negociacao gravado pela Unipessoa', :discount => 0, :area =>areas[1], :user => users[1]},
  {:name => 'Negociacao', :information => 'Curso de negociacao gravado pela Unipessoa', :discount => 0, :area =>areas[1], :user => users[1]}
])

video = Video.create([
  {
    :name => "Kinect",
    :information => "exemplo com o kinect",
    :price => 0,
    :panda_video_id => "260099a855e307f321785af0e698a938",
    :user => users[1],
    :course_id => courses[0].id
  },
  {
    :name => "Kinect",
    :information => "exemplo com o kinect",
    :price => 0,
    :panda_video_id => "260099a855e307f321785af0e698a938",
    :user => users[1],
    :course_id => courses[1].id
  }
])

users[0].purchased_videos << video[0]
users[0].purchased_videos << video[1]
users[0].save
