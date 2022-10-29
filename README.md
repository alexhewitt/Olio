# README

Hello and welcome to this simple Olio article viewer application

* Built in ruby version 3.0.0 and Rails version 6.1.7 with a Postgres Database

* To get started run the following commands from your terminal

### MacOS

- Install Homebrew

https://brew.sh/
^ Paste and copy snippet into Terminal and return.

- Install rbenv

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

- Clone repo

- Install Postgresql

```
$ brew install postgresql
$ brew services start postgresql
```

- Setup database

```
$ rails db:create db:migrate
```

- Serve Rails

```
$ rails s
```

* ...
