# Grain Assignment

[https://grain-assignment.onrender.com](https://grain-assignment.onrender.com)

<details>

<summary><strong> Installation & Deployment </strong></summary>

# Installation

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

# Deploy

Create a free Database Instance on render.com and a free Web-Service instance with Ruby as the language.

## For the DB Instance:

Name : grain-assignment
PostgreSQL Version: 16
Free Instance

Click create/deploy.

> [!NOTE]
> Copy the Internal Database URL from the DB instance once it is live.

## For the Web-Service Instance:

Connect to Repository on Github

Name : grain-assignment
Free Instance
branch: main

Build Command: bundle install; bundle exec rake assets:precompile; bundle exec rake assets:clean; ./bin/render-build.sh; ./bin/rails db:create; ./bin/rails db:migrate; ./bin/rails db:seed;

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

<details>

<summary><strong>What I learnt? </strong></summary>

### Learning 1

```
rails newapp --api
```

Creates only the backed of the Rails app and no frontend.

### Learning 2

Resolver Functions

> A resolver is a function that's responsible for populating the data for a single field in your schema.

### Learning 3

GraphQL solves the problem of over-fetching and under-fetching.
GraphQL solves these issues by allowing clients to request only the data they need thru defined queries.
E.g.

```js
query{
  allMenus{
    id
    label
    identifier
  }
  allSections{
    label
  }
}
```

Output:

```js
{
  "data": {
    "allMenus": [
      {
        "id": "1",
        "label": "Indian",
        "identifier": "shsrvjnklj"
      }
    ],
    "allSections": [
      {
        "label": "Appetizers"
      },
      {
        "label": "Main Course"
      }
    ]
  }
}
```

### Learning 4

GraphQL removing the need for adding specific routes in routes.rb is a game changer.

### Learning 5

Rails migration generator does not handle default values, but after generation of migration file you should update migration file with following code.

**_ I was aware of this earlier but I glossed over it while I was building this time round and was trying to add default values into the command line. So I'm going to include this here _**

### Learning 6

Deploying a DB on Render.com

### Learning 7

Deploying a Rails app on Render.com

### Learning 8

GraphIQL > Postman? I guess its easier since GraphIQL allows you to update the documentation directly on the files while you write code. Which serves well as both comments on the file and also descriptions for the API.

### Learning 9

GraphQL as whole was fun to learn and I think I would definitely think about integrating this in my next passion project. But I am curious as to whether it saves time and if it could change how my work flows in the backend when implemented with React.

</details>
<details>

<summary><strong> Problems & Revelations </strong></summary>

# Problems

I faced 3 Major Issues

### Setup

This issue occured during setup. My ex firm had been using Ruby 2.6 for the longest time and we were up for an upgrade.
The system refused to install the newer versions of ruby due to the error below:

```
ruby-3.0.0 - #compiling - please wait
Error running '__rvm_make -j8',
please read /Users/codomo/.rvm/log/1723882290_ruby-3.0.0/make.log
```

### Solution

Prior knowledge of using RBENV came in handy here, using Digital Ocean's setup for RBENV I managed to come across this line:

```shell
nano .bash_profile ## and adding: eval "$(rbenv init -)"
source ~/.bash_profile
```

Setting rbenv global and local to Ruby 3.3.4 got me ready.

### Model Implementation

The type field under Items model was something that I overlooked. It popped up when I tried to create/migrate/seed.

```
ActiveRecord::SubclassNotFound: The single-table inheritance mechanism failed to locate the subclass: 'Product'. This error is raised because the column 'type' is reserved for storing the class in case of inheritance. Please rename this column if you didn't intend it to be used for storing the inheritance class or overwrite Item.inheritance_column to use another column for that information. If you wish to disable single-table inheritance for Item set Item.inheritance_column to nil (ActiveRecord::SubclassNotFound)
```

### Solution

This one had a simple solution of changing the `type` field to `item_type` field using the `20240818092355_rename_type_to_item_type.rb`:

```rb
class RenameTypeToItemType < ActiveRecord::Migration[7.2]
  def change
    rename_column :items, :type, :item_type
  end
end
```

### Deployment

This one was my biggest headache. I have never done DB deployment to Render before. Nor have I deployed a Rails app to Render as well. Once I managed to get the web-service up and running with GraphIQL on the '/' path, any sort of query or mutation would throw this error. With many stones to flip and turn to solve this, I decided on using ChatGPT just to get a list of things up and walk thru them one by one. I had an inkling that this was most probably due to being unable to ping the database. But I had followed the existing Render documentation to the tee.

```
ActionController::RoutingError (No route matches [GET] "/"):

graphiql on render causing issues
      "message": "Unexpected end of JSON input",
      "stack": "SyntaxError: Unexpected end of JSON input\n    at https://grain-assignment.onrender.com/assets/graphiql/rails/application-7f32dbfdf3520d4edd60e0509a8df7b4d61ab9a10fe59bf68b909f8fd4277b66.js:84045:33\n    at async https://grain-assignment.onrender.com/assets/graphiql/rails/application-7f32dbfdf3520d4edd60e0509a8df7b4d61ab9a10fe59bf68b909f8fd4277b66.js:58422:15"

```

### Solution

Having checked issues like CORS and `routes.rb` configurations, `render-build.sh` configurations and Environment variables, which took much less time. I managed to confirm that the Database was indeed the issue an took an annoyed break to refresh my brain. Than sat down to find a Youtube video that did the deployment from start to finish and figured I had missed out adding the following commands on instance setup:

> Build Command: ./bin/rails db:create; ./bin/rails db:migrate; ./bin/rails db:seed;

> Start Command: ./bin/rails server

Creating the Database from scratch instead of using a blueprint allowed me to solve the problem quickly. As I had skipped over transferring the INTERNAL DB URL to the ENV variables:

```
DATABASE_URL : {PASTE THE COPIED INTERNAL DB URL}
```

This put an end to my misery.

</details>

<details>

<summary><strong> References, Links and Prompts </strong></summary>

# Important Links

[Grain Assignment App](https://grain-assignment.onrender.com)

[Grain Assignment DB - External URL](postgresql://grain_assignment_kvda_user:8uzpL6RKxHS3H0OENCVEFHuqMuQtVqzq@dpg-cr1bedrtq21c73cr3ceg-a.singapore-postgres.render.com/grain_assignment_kvda)

# References

[Learning GraphQL](https://www.udemy.com/course/graphql-by-example/learn/lecture/36699796?start=60#overview)
**_ Only the first 20% of the course _**

[Ruby 3.3.4](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-macos)

[Faker Gem](https://github.com/faker-ruby/faker/blob/main/doc/default/dessert.md)

[Seed File Creation](https://stackoverflow.com/questions/54160521/how-do-i-create-a-seed-file-using-a-model-with-references-im-not-sure-i-set-up)

[Building the API](https://www.youtube.com/watch?v=kSlJH3hrV58)

[Render Deployment](https://docs.render.com/deploy-rails)

[Deploying Rails App To Render](https://www.youtube.com/watch?v=2T2rfxSCBdA)

# Prompts

While facing an issue with deployment and the database returning nil, ChatGPT allowed me to form a checklist to go thru and ensure everything was in order.

```
I am attempting to run graphiql with rails on render.com. However when i query on graphiql i get a error response: XXX
```

I had also come across CORS issues many times in MERN stack development and had to ensure it wouldn't be an issue here.

```
I am attempting to run graphiql with rails on render.com. How do I ensure CORS is a non-issue: XXX
```

</details>
