# Grain Assignment

[https://grain-assignment.onrender.com](https://grain-assignment.onrender.com)

<details>

<summary><strong> Installation and Deployment </strong></summary>

## Clone the repository

```shell
git clone https://github.com/Thiru5/grain-assignment.git
cd grain-assignment
```

## Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.3.4`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.3.4
```

## Install dependencies

Using [Bundler](https://github.com/bundler/bundler) and Brew:

```shell
gem install bundler
bundler install
bundler update

```

## Initialize the database using SQLITE3

SQLite3 comes default. Will have to change to PostgreSQL for deployment later

```shell
rails db:create db:migrate db:seed
```

## Serve

```shell
rails s
```

---

## Render Deployment Setup

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
rails db:create
rails db:migrate
rails db:seed
```

Push all changes to repo.

## Deploy

Create a free Database Instance on render.com and a free Web-Service instance with Ruby as the language.

# For the DB Instance:

Name : grain-assignment
PostgreSQL Version: 16
Free Instance

Click create/deploy.

> [!NOTE]
> Copy the Internal Database URL from the DB instance once it is live.

# For the Web-Service Instance:

Connect to Repository on Github

Name : grain-assignment
Free Instance
branch: main

Build Command: bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean; ./bin/render-build.sh; ./bin/rails db:drop; ./bin/rails db:create; ./bin/rails db:migrate; ./bin/rails db:seed;

> [!IMPORTANT]
> Remember to remove db:seed command after 1st deploy - will trigger a re-deploy which is fine.

Start Command: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}; ./bin/rails server

Environment Variables:

```
DATABASE_URL : {PASTE THE COPIED INTERNAL DB URL}
RAILS_MASTER_KEY: {PASTE FROM MASTER.KEY}
WEB_CONCURRENCY: 2
```

Deploy/Create

## Directly to production (not recommended)

Pushing to Github will automatically re-deploy the main branch to render.
This has been done with main branch for this assignment alone and should not be carried out in real-world applications.
Convention is to create branches such as production, staging and demo. With all staging and demo running as private instances and production being live on render.

## Once Live

You will be able to see the GraphIQL Interface. HAPPY QUERYING!

</details>
