puts "Beginning the b_seed (creation)"

User.new(
  first_name: 'Peter',
  last_name: 'Programmer',
  email: 'Peter@example.com',
  password: 'password',
  owner: true
).save()

user = User.order("id").last

User.new(
  first_name: 'Example',
  last_name: 'Customer',
  email: 'Customer@example.com',
  password: 'password',
  owner: false
).save()

# create the store with the owner's id tying them
store = Store.create({
  name: 'Peter\'s Programming Paradise',
  email: 'petersprogrammingparadise@example.com',
  phone: '613-555-5555',
  url: 'www.petersprogrammingparadise.example.com',
  user_id: user.id
})

#create the mobile products for the store

store.products.create(name: 'iOS/Swift', value: 34.99, tags: 'mobile')

store.products.create(name: 'Android', value: 30.99, tags: 'mobile')

store.products.create(name: 'React Native', value: 50.99, tags: 'mobile')

store.products.create(name: 'Flutter', value: 25.99, tags: 'mobile')

store.products.create(name: 'Xamarin', value: 34.99, tags: 'mobile')

store.products.create(name: 'Apache Cordova', value: 34.99, tags: 'mobile')

store.products.create(name: 'Phone Gap', value: 34.99, tags: 'mobile')

#Monocross
store.products.create(name: 'Monocross', value: 34.99, tags: 'mobile')

#Appcelerator
store.products.create(name: 'Appcelerator', value: 34.99, tags: 'mobile')

#NativeScript
store.products.create(name: 'NativeScript', value: 34.99, tags: 'mobile')

#Seeding Web Frameworks

#Express.JS
store.products.create(name: 'Express.js', value: 34.99, tags: 'web')

#Flask
store.products.create(name: 'Flask', value: 34.99, tags: 'web')

#Django
store.products.create(name: 'Django', value: 34.99, tags: 'web')

#Ruby on Rails
store.products.create(name: 'Ruby on Rails', value: 34.99, tags: 'web')

#Vanilla GoLang
store.products.create(name: 'Vanilla GoLang', value: 34.99, tags: 'web')

#Laravel
store.products.create(name: 'LaRavel', value: 34.99, tags: 'web')

#Symfony
store.products.create(name: 'Symfony', value: 34.99, tags: 'web')

#Sinatra
store.products.create(name: 'Sinatra', value: 34.99, tags: 'web')

#Sails.js
store.products.create(name: 'Sails.js', value: 34.99, tags: 'web')

#Cake PHP
store.products.create(name: 'Cake PHP', value: 34.99, tags: 'web')


#Seeding Front-End Frameworks

#React/Redux
store.products.create(name: 'React.js', value: 34.99, tags: 'front-end')

#Angular
store.products.create(name: 'Angular.js', value: 34.99, tags: 'front-end')

#Vue.js
store.products.create(name: 'Vue.js', value: 34.99, tags: 'front-end')

#Bootstrap
store.products.create(name: 'Bootstrap', value: 34.99, tags: 'front-end')

#SemanticUI
store.products.create(name: 'Semantic UI', value: 34.99, tags: 'front-end')

#Materialize
store.products.create(name: 'Materialize', value: 34.99, tags: 'front-end')

#Ember.js
store.products.create(name: 'Ember.js', value: 34.99, tags: 'front-end')

#Pure CSS
store.products.create(name: 'Pure CSS', value: 34.99, tags: 'front-end')

#Backbone CSS
store.products.create(name: 'Backbone CSS', value: 34.99, tags: 'front-end')

#Skeleton CSS
store.products.create(name: 'Skeleton CSS', value: 34.99, tags: 'front-end')

#Seeding DBS

#Oracle
store.products.create(name: 'Oracle', value: 34.99, tags: 'database')

#MySQL
store.products.create(name: 'MySQL', value: 34.99, tags: 'database')

#Microsoft SQL Server
store.products.create(name: 'Microsoft SQL Server', value: 34.99, tags: 'database')

#Postgre SQL
store.products.create(name: 'Postgre SQL', value: 34.99, tags: 'database')

#MongoDB
store.products.create(name: 'MongoDB', value: 34.99, tags: 'database')

#Maria DB
store.products.create(name: 'Maria DB', value: 34.99, tags: 'database')

#IBM DB2
store.products.create(name: 'IBM DB2', value: 34.99, tags: 'database')

#SAP HANNA
store.products.create(name: 'SAP HANNA', value: 34.99, tags: 'database')

#SQLite
store.products.create(name: 'SQLite', value: 34.99, tags: 'database')

#Redis
store.products.create(name: 'Redis', value: 34.99, tags: 'database')

#Seeding DevOps Software

#Jenkins
store.products.create(name: 'Jenkins', value: 34.99, tags: 'devOps')

#BuildKite
store.products.create(name: 'BuildKite', value: 34.99, tags: 'devOps')

#Prometheus
store.products.create(name: 'Prometheus', value: 34.99, tags: 'devOps')

#LogStash
store.products.create(name: 'LogStash', value: 34.99, tags: 'devOps')

#DataDog
store.products.create(name: 'DataDog', value: 34.99, tags: 'devOps')

#Docker
store.products.create(name: 'Docker', value: 34.99, tags: 'devOps')

#Kubernetes
store.products.create(name: 'Kubernetes', value: 34.99, tags: 'devOps')

#Vagrant
store.products.create(name: 'Vagrant', value: 34.99, tags: 'devOps')

#TeamCity by JetBrains
store.products.create(name: 'TeamCity by JetBrains', value: 34.99, tags: 'devOps')

#Pingdom
store.products.create(name: 'Pingdom', value: 34.99, tags: 'devOps')

#Seeding Text Editors/IDEs

#Android Studio
store.products.create(name: 'Android Studio', value: 34.99, tags: 'text editors/IDEs')

#XCode
store.products.create(name: 'XCode', value: 34.99, tags: 'text editors/IDEs')

#Visual Studio
store.products.create(name: 'Visual Studio', value: 34.99, tags: 'text editors/IDEs')

#Atom
store.products.create(name: 'Atom', value: 34.99, tags: 'text editors/IDEs')

#Eclipse
store.products.create(name: 'Eclipse', value: 34.99, tags: 'text editors/IDEs')

#IDLE
store.products.create(name: 'IDLE', value: 34.99, tags: 'text editors/IDEs')

#Sublime
store.products.create(name: 'Sublime', value: 34.99, tags: 'text editors/IDEs')

#Vim
store.products.create(name: 'Vim', value: 34.99, tags: 'text editors/IDEs')

#Notepad ++
store.products.create(name: 'Notepad ++', value: 34.99, tags: 'text editors/IDEs')

#Brackets
store.products.create(name: 'Brackets', value: 34.99, tags: 'text editors/IDEs')

puts "Ending the b_seed (creation)"
