# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# create the default MixedFieldTypes
MixedFieldType.create! :name => "Developer"
MixedFieldType.create! :name => "Publisher"
MixedFieldType.create! :name => "Distributor"
MixedFieldType.create! :name => "Credits"