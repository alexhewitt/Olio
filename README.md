# README

Hello and welcome to my Olio article viewer application. Get started with the instructions below.

* Built in Ruby 3.0.0, Rails 6.1.7 and Postgres 14.5

* To get started run the following commands from your terminal

### MacOS - Basic Setup

- Install Homebrew

https://brew.sh/
^ Paste and copy snippet into Terminal and return.

- Install rbenv ruby manager ( or use the ruby manager of your choice )

```
$ brew install rbenv
```

- Init rbenv (bash shell)

```
$ rbenv init
# ^ follow the instructions displayed and restart terminal
$ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
```

- Init rbenv (fish shell)
^ Add the following line in ~/.config/fish/config.fish file

```
status --is-interactive; and source (rbenv init -|psub)
```

- Install Ruby & Rails

```
$ rbenv install 3.0.0
$ rbenv global 3.0.0
$ rbenv rehash
$ gem install bundler
$ rbenv rehash
```

- Install Postgresql & Postgis

```
$ brew install postgresql

$ brew install postgis

$ brew services start postgresql
```

- Install bundler gem

```
$ gem install bundler:2.2.3
```


- Download Gemset

```
$ bundle install
```


- Setup database

```
$ rails db:create db:migrate db:seed
```

### Database issues usually relate to postgis. 
## To remedy any issues please try installing the postgis extension in your postgres database first.

- Serve Rails

```
$ rails s
```

* ...
