# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create(email: 'dm.zgroupsoft@gmail.com', password: '11111111')

r1 = Group.create(title: 'Sample', icon: 6, user_id: u1.id)
r2 = Group.create(title: 'Next', icon: 7, user_id: u1.id)
r3 = Group.create(title: 'Third', icon: 8, user_id: u1.id)
r4 = Group.create(title: 'Fourth', icon: 9, user_id: u1.id)

r2f1 = Group.create(title: 'Child', icon: 12, group_id: r2.id, user_id: u1.id)
r2f2 = Group.create(title: 'Folder', icon: 16, group_id: r2.id, user_id: u1.id)
r2f3 = Group.create(title: 'Parent', icon: 19, group_id: r2.id, user_id: u1.id)
r2f4 = Group.create(title: 'Next', icon: 20, group_id: r2.id, user_id: u1.id)

r2f3f1 = Group.create(title: 'Deep', icon: 22, group_id: r2f3.id, user_id: u1.id)
r2f3f1 = Group.create(title: 'Level', icon: 23, group_id: r2f3.id, user_id: u1.id)

r4f1 = Group.create(title: 'Another', icon: 24, group_id: r4.id, user_id: u1.id)
r4f2 = Group.create(title: 'One', icon: 25, group_id: r4.id, user_id: u1.id)

e1 = Entry.create(title: 'Test', login: 'User', password: '11111', icon: 26, url: 'http://debian.org', group_id: r3.id)
e2 = Entry.create(title: 'Test2', login: 'User2', password: '11111', icon: 27, url: 'http://google.com', group_id: r3.id)
e3 = Entry.create(title: 'Test3', login: 'User3', password: '11111', icon: 28, url: 'http://sample.org', group_id: r3.id)
e4 = Entry.create(title: 'Test4', login: 'User4', password: '11111', icon: 29, url: 'http://smaple.com', group_id: r3.id)
e5 = Entry.create(title: 'Test5', login: 'User5', password: '11111', icon: 30, url: 'http://mail.com', group_id: r3.id)
