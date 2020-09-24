# Rails Starter App

Are you sick of jumping through all the hoops of setting up a big Rails app only to throw the idea down the drain cause you got sick of it? 

Well now you dont have to because I have an easy to use Rails template that kicks ass for you and lets you focus only on the Product idea.

Our template sets up a tons of essential app components for you to make your development pretty damn fast.

## Features

- A default set of Models, Controllers, and Views
- Integrated front-end libraries such as jQuery, Bootstrap 4, Font-awesome 4, Turbolinks, AdminLTE v3 to get started fast
- `slim` HTML templating for ease of development
- Plain `sprockets` handled Javascript (strongly recommended) and `webpacker` are both integrated
- Simple front-end dependency management using a view partial that outputs <script> tags
- File uploads are handled by `active_storage` with both remote and local options configured
- Testing is setup with `minitest` and `capybara`
- Deployment is handled with `mina`. Capistrano was not chosen because it has an rough outdated eco-system.
- Zero-downtime restarts with `mina-ng-puma`
- Server Configuration Helpers for `monit`, `nginx example`, `https ssl example`, `logrotate`, `backup example` is ready for you
- ActionCable is disabled, you can enable it once you "actually" need it

## Usage

The following command creates a new app caled `rails_starter_app`

```
find_replace(){
  grep -rl --exclude-dir="\.git" --exclude"README.md" "$1" $3 | xargs sed -i "s/$1/$2/g"
}

find_replace RailsStarterApp YourAppName
find_replace rails_starter_app your_app_name
```

## Guides

* [Server Setup]()https://github.com/westonganger/rails_starter_app/blob/master/docs/server_setup.md
* [Deployment](https://github.com/westonganger/rails_starter_app/blob/master/docs/deploy.md)

## Credits

Created and maintained by [@westonganger](https://github.com/westonganger)
