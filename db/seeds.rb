# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u1 = User.create(email: 'dm.zgroupsoft@gmail.com', password: '11111111')
root = u1.groups.root

r1 = root.children.create(title: 'Sample', icon: 6, user_id: u1.id)
r2 = root.children.create(title: 'Next', icon: 7, user_id: u1.id)
r3 = root.children.create(title: 'Third', icon: 8, user_id: u1.id)
r4 = root.children.create(title: 'Fourth', icon: 9, user_id: u1.id)
r5 = root.children.create(title: 'Fifth', icon: 10, user_id: u1.id)

r2f1 = r2.children.create(title: 'Child', icon: 12, user_id: u1.id)
r2f2 = r2.children.create(title: 'Folder', icon: 16, user_id: u1.id)
r2f3 = r2.children.create(title: 'Parent', icon: 19, user_id: u1.id)
r2f4 = r2.children.create(title: 'Next', icon: 20, user_id: u1.id)

r2f3f1 = r2f3.children.create(title: 'Deep', icon: 22, user_id: u1.id)
r2f3f1 = r2f3.children.create(title: 'Level', icon: 23, user_id: u1.id)

r4f1 = r4.children.create(title: 'Another', icon: 24, user_id: u1.id)
r4f2 = r4.children.create(title: 'One', icon: 25, user_id: u1.id)

e1 = r3.entries.create(title: 'Test', login: 'User', password: '11111', icon: 26, url: 'http://debian.org')
e2 = r3.entries.create(title: 'Test2', login: 'User2', password: '11111', icon: 27, url: 'http://google.com')
e3 = r3.entries.create(title: 'Test3', login: 'User3', password: '11111', icon: 28, url: 'http://sample.org')
e4 = r3.entries.create(title: 'Test4', login: 'User4', password: '11111', icon: 29, url: 'http://smaple.com')
e5 = r3.entries.create(title: 'Test5', login: 'User5', password: '11111', icon: 30, url: 'http://mail.com')
