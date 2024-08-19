# Project

[https://grain-assignment.onrender.com](https://grain-assignment.onrender.com)

## Install

### Clone the repository

```shell
git clone https://github.com/Thiru5/grain-assignment.git
cd grain-assignment
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.3.4`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.3.4
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and Brew:

```shell
gem install bundler
bundler install
bundler update

```

### Initialize the database using SQLITE3

SQLite3 comes default. Will have to change to PostgreSQL for deployment later

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

## Set Up Render Deployment

Create file called `/bin/render-build.sh` and add in the following:

```sh
#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

# bundle exec rails db:migrate
```

Create file called `render.yaml` in the root directory of the app and add the following:

```yaml
databases:
  - name: mysite
    databaseName: mysite
    user: mysite
    plan: free

services:
  - type: web
    name: mysite
    runtime: ruby
    plan: free
    buildCommand: "./bin/render-build.sh"
    # preDeployCommand: "bundle exec rails db:migrate" # preDeployCommand only available on paid instance types
    startCommand: "bundle exec rails server"
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: mysite
          property: connectionString
      - key: RAILS_MASTER_KEY
        sync: false
      - key: WEB_CONCURRENCY
        value: 2 # sensible default
```

## Switch from SQLite3 to PostgreSQL

Ensure you have postgresql installed, [user created](https://www.strongdm.com/blog/postgres-create-user) and also service running.

```shell
brew install postgresql
brew services start postgresql
```

Run this command after:

```shell
rails db:system:change --to=postgresql
```

## Deploy

### With Render pipeline (recommended)

Push to Github Repo

```shell
git push main
```

Go to the Heroku Dashboard and [promote the app to production](https://devcenter.heroku.com/articles/pipelines) or use Heroku CLI:

```shell
heroku pipelines:promote -a project-staging
```

### Directly to production (not recommended)

Push to Heroku production remote:

```shell
git push heroku
```
