puts "seeding data"


#Seeding Mobile Frameworks

#ios
Product.create(name: 'iOS/Swift', value: 34.99, tags: 'mobile, apple').items.create(
  [
    {name: 'iOS/Swift (base)', value: 34.99},
    {name: 'iOS/Swift (+1 year service)', value: 44.99},
    {name: 'iOS/Swift (+2 year service)', value: 54.99}
  ])

  #Android
  Product.create(name: 'Android', value: 30.99, tags: 'mobile').items.create(
    [
      {name: 'Android (base)', value: 30.99},
      {name: 'Android (+1 year service)', value: 40.99},
      {name: 'Android (+2 year service)', value: 50.99}
    ])

  #React Native
  Product.create(name: 'React Native', value: 50.99, tags: 'mobile').items.create(
    [
      {name: 'React Native (base)', value: 50.99},
      {name: 'React Native (+1 year service)', value: 60.99},
      {name: 'React Native (+2 year service)', value: 70.99}
    ])

  #Flutter
  Product.create(name: 'Flutter', value: 25.99, tags: 'mobile').items.create(
    [
      {name: 'Flutter (base)', value: 25.99},
      {name: 'Flutter (+1 year service)', value: 35.99},
      {name: 'Flutter (+2 year service)', value: 45.99}
    ])

  #Xamarin
  Product.create(name: 'Xamarin', value: 34.99, tags: 'mobile').items.create(
    [
      {name: 'Xamarin (base)', value: 34.99},
      {name: 'Xamarin (+1 year service)', value: 44.99},
      {name: 'Xamarin (+2 year service)', value: 54.99}
    ])

  #Apache Cordova
  Product.create(name: 'Apache Cordova', value: 34.99, tags: 'mobile').items.create(
    [
      {name: 'Apache Cordova (base)', value: 34.99},
      {name: 'Apache Cordova (+1 year service)', value: 44.99},
      {name: 'Apache Cordova (+2 year service)', value: 54.99}
    ])

 #Phone Gap
 Product.create(name: 'Phone Gap', value: 34.99, tags: 'mobile').items.create(
   [
     {name: 'Phone Gap (base)', value: 34.99},
     {name: 'Phone Gap (+1 year service)', value: 44.99},
     {name: 'Phone Gap (+2 year service)', value: 54.99}
   ])

 #Monocross
 Product.create(name: 'Monocross', value: 34.99, tags: 'mobile').items.create(
   [
     {name: 'Monocross (base)', value: 34.99},
     {name: 'Monocross (+1 year service)', value: 44.99},
     {name: 'Monocross (+2 year service)', value: 54.99}
   ])

 #Appcelerator
 Product.create(name: 'Appcelerator', value: 34.99, tags: 'mobile').items.create(
   [
     {name: 'Appcelerator (base)', value: 34.99},
     {name: 'Appcelerator (+1 year service)', value: 44.99},
     {name: 'Appcelerator (+2 year service)', value: 54.99}
   ])

 #NativeScript
 Product.create(name: 'NativeScript', value: 34.99, tags: 'mobile').items.create(
   [
     {name: 'NativeScript (base)', value: 34.99},
     {name: 'NativeScript (+1 year service)', value: 44.99},
     {name: 'NativeScript (+2 year service)', value: 54.99}
   ])

 #Seeding Web Frameworks

 #Express.JS
 Product.create(name: 'Express.js', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Express.js (base)', value: 34.99},
     {name: 'Express.js (+1 year service)', value: 44.99},
     {name: 'Express.js (+2 year service)', value: 54.99}
   ])

 #Flask
 Product.create(name: 'Flask', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Flask (base)', value: 34.99},
     {name: 'Flask (+1 year service)', value: 44.99},
     {name: 'Flask (+2 year service)', value: 54.99}
   ])

 #Django
 Product.create(name: 'Django', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Django (base)', value: 34.99},
     {name: 'Django (+1 year service)', value: 44.99},
     {name: 'Django (+2 year service)', value: 54.99}
   ])

 #Ruby on Rails
 Product.create(name: 'Ruby on Rails', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Ruby on Rails (base)', value: 34.99},
     {name: 'Ruby on Rails (+1 year service)', value: 44.99},
     {name: 'Ruby on Rails (+2 year service)', value: 54.99}
   ])

 #Vanilla GoLang
 Product.create(name: 'Vanilla GoLang', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Vanilla GoLang (base)', value: 34.99},
     {name: 'Vanilla GoLang (+1 year service)', value: 44.99},
     {name: 'Vanilla GoLang (+2 year service)', value: 54.99}
   ])

 #Laravel
 Product.create(name: 'LaRavel', value: 34.99, tags: 'web').items.create(
   [
     {name: 'LaRavel (base)', value: 34.99},
     {name: 'LaRavel (+1 year service)', value: 44.99},
     {name: 'LaRavel (+2 year service)', value: 54.99}
   ])

 #Symfony
 Product.create(name: 'Symfony', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Symfony (base)', value: 34.99},
     {name: 'Symfony (+1 year service)', value: 44.99},
     {name: 'Symfony (+2 year service)', value: 54.99}
   ])

 #Sinatra
 Product.create(name: 'Sinatra', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Sinatra (base)', value: 34.99},
     {name: 'Sinatra (+1 year service)', value: 44.99},
     {name: 'Sinatra (+2 year service)', value: 54.99}
   ])

 #Sails.js
 Product.create(name: 'Sails.js', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Sails.js (base)', value: 34.99},
     {name: 'Sails.js (+1 year service)', value: 44.99},
     {name: 'Sails.js (+2 year service)', value: 54.99}
   ])

 #Cake PHP
 Product.create(name: 'Cake PHP', value: 34.99, tags: 'web').items.create(
   [
     {name: 'Cake PHP (base)', value: 34.99},
     {name: 'Cake PHP (+1 year service)', value: 44.99},
     {name: 'Cake PHP (+2 year service)', value: 54.99}
   ])


 #Seeding Front-End Frameworks

 #React/Redux
 Product.create(name: 'React.js', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'React.js (base)', value: 34.99},
     {name: 'React.js (+1 year service)', value: 44.99},
     {name: 'React.js (+2 year service)', value: 54.99}
   ])

 #Angular
 Product.create(name: 'Angular.js', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Angular.js (base)', value: 34.99},
     {name: 'Angular.js (+1 year service)', value: 44.99},
     {name: 'Angular.js (+2 year service)', value: 54.99}
   ])

 #Vue.js
 Product.create(name: 'Vue.js', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Vue.js (base)', value: 34.99},
     {name: 'Vue.js (+1 year service)', value: 44.99},
     {name: 'Vue.js (+2 year service)', value: 54.99}
   ])

 #Bootstrap
 Product.create(name: 'Bootstrap', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Bootstrap (base)', value: 34.99},
     {name: 'Bootstrap (+1 year service)', value: 44.99},
     {name: 'Bootstrap (+2 year service)', value: 54.99}
   ])

 #SemanticUI
 Product.create(name: 'Semantic UI', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Semantic UI (base)', value: 34.99},
     {name: 'Semantic UI (+1 year service)', value: 44.99},
     {name: 'Semantic UI (+2 year service)', value: 54.99}
   ])

 #Materialize
 Product.create(name: 'Materialize', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Materialize (base)', value: 34.99},
     {name: 'Materialize (+1 year service)', value: 44.99},
     {name: 'Materialize (+2 year service)', value: 54.99}
   ])

 #Ember.js
 Product.create(name: 'Ember.js', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Ember.js (base)', value: 34.99},
     {name: 'Ember.js (+1 year service)', value: 44.99},
     {name: 'Ember.js (+2 year service)', value: 54.99}
   ])

 #Pure CSS
 Product.create(name: 'Pure CSS', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Pure CSS (base)', value: 34.99},
     {name: 'Pure CSS (+1 year service)', value: 44.99},
     {name: 'Pure CSS (+2 year service)', value: 54.99}
   ])

 #Backbone CSS
 Product.create(name: 'Backbone CSS', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Backbone CSS (base)', value: 34.99},
     {name: 'Backbone CSS (+1 year service)', value: 44.99},
     {name: 'Backbone CSS (+2 year service)', value: 54.99}
   ])

 #Skeleton CSS
 Product.create(name: 'Skeleton CSS', value: 34.99, tags: 'front-end').items.create(
   [
     {name: 'Skeleton CSS (base)', value: 34.99},
     {name: 'Skeleton CSS (+1 year service)', value: 44.99},
     {name: 'Skeleton CSS (+2 year service)', value: 54.99}
   ])



 #Seeding DBS

 #Oracle
 Product.create(name: 'Oracle', value: 34.99, tags: 'database').items.create(
   [
     {name: 'Oracle (base)', value: 34.99},
     {name: 'Oracle (+1 year service)', value: 44.99},
     {name: 'Oracle (+2 year service)', value: 54.99}
   ])

 #MySQL
 Product.create(name: 'MySQL', value: 34.99, tags: 'database').items.create(
   [
     {name: 'MySQL (base)', value: 34.99},
     {name: 'MySQL (+1 year service)', value: 44.99},
     {name: 'MySQL (+2 year service)', value: 54.99}
   ])

 #Microsoft SQL Server
 Product.create(name: 'Microsoft SQL Server', value: 34.99, tags: 'database').items.create(
   [
     {name: 'Microsoft SQL Server (base)', value: 34.99},
     {name: 'Microsoft SQL Server (+1 year service)', value: 44.99},
     {name: 'Microsoft SQL Server (+2 year service)', value: 54.99}
   ])

 #Postgre SQL
 Product.create(name: 'Postgre SQL', value: 34.99, tags: 'database').items.create(
   [
     {name: 'Postgre SQL (base)', value: 34.99},
     {name: 'Postgre SQL (+1 year service)', value: 44.99},
     {name: 'Postgre SQL (+2 year service)', value: 54.99}
   ])

 #MongoDB
 Product.create(name: 'MongoDB', value: 34.99, tags: 'database').items.create(
   [
     {name: 'MongoDB (base)', value: 34.99},
     {name: 'MongoDB (+1 year service)', value: 44.99},
     {name: 'MongoDB (+2 year service)', value: 54.99}
   ])

 #Maria DB
 Product.create(name: 'Maria DB', value: 34.99, tags: 'database').items.create(
   [
     {name: 'Maria DB (base)', value: 34.99},
     {name: 'Maria DB (+1 year service)', value: 44.99},
     {name: 'Maria DB (+2 year service)', value: 54.99}
   ])

 #IBM DB2
 Product.create(name: 'IBM DB2', value: 34.99, tags: 'database').items.create(
   [
     {name: 'IBM DB2 (base)', value: 34.99},
     {name: 'IBM DB2 (+1 year service)', value: 44.99},
     {name: 'IBM DB2 (+2 year service)', value: 54.99}
   ])

 #SAP HANNA
 Product.create(name: 'SAP HANNA', value: 34.99, tags: 'database').items.create(
   [
     {name: 'SAP HANNA (base)', value: 34.99},
     {name: 'SAP HANNA (+1 year service)', value: 44.99},
     {name: 'SAP HANNA (+2 year service)', value: 54.99}
   ])

 #SQLite
 Product.create(name: 'SQLite', value: 34.99, tags: 'database').items.create(
   [
     {name: 'SQLite (base)', value: 34.99},
     {name: 'SQLite (+1 year service)', value: 44.99},
     {name: 'SQLite (+2 year service)', value: 54.99}
   ])

 #Redis
 Product.create(name: 'Redis', value: 34.99, tags: 'database').items.create(
   [
     {name: 'Redis (base)', value: 34.99},
     {name: 'Redis (+1 year service)', value: 44.99},
     {name: 'Redis (+2 year service)', value: 54.99}
   ])


 #Seeding DevOps Software

 #Jenkins
 Product.create(name: 'Jenkins', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Jenkins (base)', value: 34.99},
     {name: 'Jenkins (+1 year service)', value: 44.99},
     {name: 'Jenkins (+2 year service)', value: 54.99}
   ])

 #BuildKite
 Product.create(name: 'BuildKite', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'BuildKite (base)', value: 34.99},
     {name: 'BuildKite (+1 year service)', value: 44.99},
     {name: 'BuildKite (+2 year service)', value: 54.99}
   ])

 #Prometheus
 Product.create(name: 'Prometheus', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Prometheus (base)', value: 34.99},
     {name: 'Prometheus (+1 year service)', value: 44.99},
     {name: 'Prometheus (+2 year service)', value: 54.99}
   ])

 #LogStash
 Product.create(name: 'LogStash', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'LogStash (base)', value: 34.99},
     {name: 'LogStash (+1 year service)', value: 44.99},
     {name: 'LogStash (+2 year service)', value: 54.99}
   ])

 #DataDog
 Product.create(name: 'DataDog', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'DataDog (base)', value: 34.99},
     {name: 'DataDog (+1 year service)', value: 44.99},
     {name: 'DataDog (+2 year service)', value: 54.99}
   ])

 #Docker
 Product.create(name: 'Docker', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Docker (base)', value: 34.99},
     {name: 'Docker (+1 year service)', value: 44.99},
     {name: 'Docker (+2 year service)', value: 54.99}
   ])

 #Kubernetes
 Product.create(name: 'Kubernetes', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Kubernetes (base)', value: 34.99},
     {name: 'Kubernetes (+1 year service)', value: 44.99},
     {name: 'Kubernetes (+2 year service)', value: 54.99}
   ])

 #Vagrant
 Product.create(name: 'Vagrant', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Vagrant (base)', value: 34.99},
     {name: 'Vagrant (+1 year service)', value: 44.99},
     {name: 'Vagrant (+2 year service)', value: 54.99}
   ])

 #TeamCity by JetBrains
 Product.create(name: 'TeamCity by JetBrains', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'TeamCity by JetBrains (base)', value: 34.99},
     {name: 'TeamCity by JetBrains (+1 year service)', value: 44.99},
     {name: 'TeamCity by JetBrains (+2 year service)', value: 54.99}
   ])

 #Pingdom
 Product.create(name: 'Pingdom', value: 34.99, tags: 'devOps').items.create(
   [
     {name: 'Pingdom (base)', value: 34.99},
     {name: 'Pingdom (+1 year service)', value: 44.99},
     {name: 'Pingdom (+2 year service)', value: 54.99}
   ])

 #Seeding Text Editors/IDEs

 #Android Studio
 Product.create(name: 'Android Studio', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Android Studio (base)', value: 34.99},
     {name: 'Android Studio (+1 year service)', value: 44.99},
     {name: 'Android Studio (+2 year service)', value: 54.99}
   ])

 #XCode
 Product.create(name: 'XCode', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'XCode (base)', value: 34.99},
     {name: 'XCode (+1 year service)', value: 44.99},
     {name: 'XCode (+2 year service)', value: 54.99}
   ])

 #Visual Studio
 Product.create(name: 'Visual Studio', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Visual Studio (base)', value: 34.99},
     {name: 'Visual Studio (+1 year service)', value: 44.99},
     {name: 'Visual Studio (+2 year service)', value: 54.99}
   ])

 #Atom
 Product.create(name: 'Atom', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Atom (base)', value: 34.99},
     {name: 'Atom (+1 year service)', value: 44.99},
     {name: 'Atom (+2 year service)', value: 54.99}
   ])

 #Eclipse
 Product.create(name: 'Eclipse', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Eclipse (base)', value: 34.99},
     {name: 'Eclipse (+1 year service)', value: 44.99},
     {name: 'Eclipse (+2 year service)', value: 54.99}
   ])

 #IDLE
 Product.create(name: 'IDLE', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'IDLE (base)', value: 34.99},
     {name: 'IDLE (+1 year service)', value: 44.99},
     {name: 'IDLE (+2 year service)', value: 54.99}
   ])

 #Sublime
 Product.create(name: 'Sublime', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Sublime (base)', value: 34.99},
     {name: 'Sublime (+1 year service)', value: 44.99},
     {name: 'Sublime (+2 year service)', value: 54.99}
   ])

 #Vim
 Product.create(name: 'Vim', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Vim (base)', value: 34.99},
     {name: 'Vim (+1 year service)', value: 44.99},
     {name: 'Vim (+2 year service)', value: 54.99}
   ])

 #Notepad ++
 Product.create(name: 'Notepad ++', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Notepad ++ (base)', value: 34.99},
     {name: 'Notepad ++ (+1 year service)', value: 44.99},
     {name: 'Notepad ++ (+2 year service)', value: 54.99}
   ])

 #Brackets
 Product.create(name: 'Brackets', value: 34.99, tags: 'text editors/IDEs').items.create(
   [
     {name: 'Brackets (base)', value: 34.99},
     {name: 'Brackets (+1 year service)', value: 44.99},
     {name: 'Brackets (+2 year service)', value: 54.99}
   ])

   puts "seeding complete."
