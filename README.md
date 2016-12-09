# systematize

<p align="center">
<img src="https://s15.postimg.org/jupy0v0or/shuffler.gif" width="100%" />
</p>

## Why does this even exist ?

So you can seperate the data and structure migrations in different folders, because you know organization and stuff.

## Installation

If you're using a `Gemfile`, just add it to your project
```gemfile
#Gemfile
gem 'systematize'
```

Or just add it via `bundler`
```gemfile
bundle install 'systematize'
```

## Structure
So as the structural migrations live in the `db/migrate` folder, the data migrations shall live in the `db/data` folder:

```gemfile
- app
  |
  |-db
    |-data
    |-migrate
```

## Usage
After installing you'll see the following tasks pop-up:

```bash
$> bundle exec rake -T
rake systematize:migrate       # Migrate the database
rake systematize:rollback      # Rollback the database (options: STEP=x, VERBOSE=false)
rake systematize:rollback_all  # Rollback all the database
```

Now if you need to migrate the database you just need to run:
```bash
bundle exec rake systematize:migrate
```

Needing to rollback the previous migration? No problem.
```bash
bundle exec rake systematize:rollback
```

Need to rollback 2/3/4 migrations? I got you.
```bash
bundle exec rake systematize:rollback STEP=2
```

Made a mess so big you need to start fresh? Do it. (the migrations need to be reversible 😅)
```bash
bundle exec rake systematize:rollback_all
```

## Why was this frankstein created ? 👹

One of the most important things that a ruby application can have are the migrations, but they can be one of 2 kinds:
- Structural migrations
- Data migrations

If you want to organize said migrations in their purpose you'll probably have a folder for the struture ones and another for the data ones. But with that separation comes a problem, when should you run one type and when to run the other?
Probably the sanner way of doing it is we firstly run the structure migrations and after that we run the data migrations, but with this approach one problem will rise:

What if I have a new field that is initially populated taking into account another field, and after that we can delete that other field?
Imagine the following scenario:
- You have a `Post` model that initially has a boolean field called `:deleted`.
- After some time, and some deleted `Posts`, you need to know when that post has been deleted. So you create a `:deleted_at` field that will contain the time of the deletion.
- You can now delete the old `:deleted` field because it turned obsolete, so you create the migration to do it.

On this scenario we will have 2 structure migrations (create the `:deleted_at` field and removing the `:deleted` field) and a data migration (go through all the Posts and add the time to `:deleted_at` if they are `:deleted`). With previous migration approach, running all the migrations would fail because when the data migration run we wouldn't have the `:deleted` field because it was deleted by the structure migration.

This is when `systematize` comes in for the rescue 🚀

## Caveats
- The migrations need to follow the Rails convention to them `YYYYMMDDHHMMSS_create_products.rb`
- The migrations are wrapped around a `ActiveRecord::Base.transaction`, so if any of the migration fails the batch of migrations will rollback, until the previous successful batch.

## TODO
- [ ] Customizable folder configuration
- [ ] Customizable transaction type configuration

## Contributing
I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request. Here are some basic rules to follow to ensure timely addition of your request:
  1. If its a feature, bugfix, or anything please only change code to what you specify.
  2. Please keep PR titles easy to read and descriptive of changes, this will make them easier to merge :)
  3. Pull requests _must_ be made against `develop` branch. Any other branch (unless specified by the maintainers) will get rejected.
  4. Check for existing [issues](https://github.com/brazunisdelamancha/milagre/issues) first, before filing an issue.
  5. Have fun!

### Created & Maintained By
[Ricardo Brazunis](https://github.com/brazunisdelamancha) ([@ricardão](https://www.twitter.com/brazunisdelamancha))
