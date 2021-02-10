# Location Sharing App using Rails and Openlayer

Application demonstrating a real time location sharing features with the help of rails MVC architechture.


## Want to try it?

### Option 1 — Visit the hosted version



### Option 2 — Run it locally

#### Prerequisites

* Ruby - 2.7.2
* Rails - 6.1.1
* yarn (or npm)
* PostgreSQL/Mysql [I have used mysql in my local environment]
* openlayer - 6.5 as map library
* Bootstrap - 4.3.1
* jQuery - 3.5.1

#### Setup

```
$ git clone https://github.com/ashismanna/location-sahring-app.git
$ cd location-sahring-app/
install rails and ruby if not installed
$ bundle install
$ yarn install (or npm install)
$ rake db:setup
$ rake db:seed
```

#### Running

```
$ rails s [-p XXXX] if you want to open local server on different port
```

Now you can visit http://localhost:3000 to play with the demo site.