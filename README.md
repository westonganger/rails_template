# Rails Starter App

An easy to use Rails template that kicks ass for you and lets you focus on the Product idea.
Our template sets up a tons of essential components for you to make your development pretty damn fast.

## Setting Up New App 

The following command creates a new app caled `rails_starter_app`

```
find_replace(){
  grep -rl --exclude-dir="\.git" --exclude"README.md" "$1" $3 | xargs sed -i "s/$1/$2/g"
}

find_replace RailsStarterApp YourAppName
find_replace rails_starter_app your_app_name

git remote remove origin
git remote add origin <your-git-url-here>

git add -A
git commit -m 'git-er-done'
git push origin master
```

## Development Setup

bundle install
rake db:setup
rake db:migrate
rails s

## Guides / Documentation

* https://github.com/westonganger/rails_starter_app/blob/master/docs/table_of_contents.md

## Credits

Created and maintained by [@westonganger](https://github.com/westonganger)
