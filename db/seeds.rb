# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

staff=Staff.create!(:email=>'admin@yahoo.com',:name=>'admin',:password=>'admin')

Priority.create(priority_name: 'High')
Priority.create(priority_name: 'Medium')
Priority.create(priority_name: 'Low')

Type.create(type_name: 'Project')
Type.create(type_name: 'Knowledge')


Status.create(status_name: 'Assigned')
Status.create(status_name: 'Completed')

Component.create(component_name: 'CCMA')
Component.create(component_name: 'PBX')
Component.create(component_name: 'RUBY')
Component.create(component_name: 'REPORTS')
