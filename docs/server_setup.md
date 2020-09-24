# How to setup to your Debian / Ubuntu server

## Expression Conventions

> The beginning of `#` means that the command is executed with root authority.
>
> The beginning of `$` means that the command is executed with ruby ​​user permissions.
>
> Switch from root to ruby user, use `su - ruby`, the role of `-` can ensure that the environment variables of the ruby user are loaded correctly.
>
> If there is `xxx` in the command, please replace it with your own project name.

# Basic

## SSH into your server as root

```bash
$ ssh root@yourserverip
```

Enter the password to ensure a successful login.

## Ready to work

Update the source, and install the necessary users.

```
# apt-get update
```

```
# apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev imagemagick libmagickwand-dev
```

## Create new user ruby

```
# adduser ruby # (don't use useradd)
```
Just enter a complex password, because in the future we will only use the sshkey login method of Ruby users.

## Install rbenv + Ruby as `ruby` user

```
# su - ruby
```

The first step, install rbenv (https://github.com/rbenv/rbenv)

The following are the key installation steps

```
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

$ echo'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
$ echo'eval "$(rbenv init -)"' >> ~/.bashrc
$ echo'source ~/.bashrc' >> ~/.bash_profile
$ source ~/.bash_profile

$ rbenv install 2.7.1
$ rbenv global 2.7.1
$ rbenv rehash
```

The second step, install rails depends on `gem` and `bundler`

```
$ gem update --system
```

```
$ gem install bundler
```

## mina & setup

Ready to publish catalog

```
# mkdir -p /data/www/
# chown ruby:ruby /data/www
```

Prepare passwordless login

```
$ ssh-keygen
$ vi ~/.ssh/authorized_keys (then copy the content of id_rsa.pub of this machine and write.)
```

Open a new local terminal and test whether it is ok:

```
$ ssh ruby@yourserverip
```

You can log in without a password, indicating that the configuration has been successful.

Prepare github clone permission

```
$ cat ~/.ssh/id_rsa.pub
```

Copy the output to the deploy key of the github repository to ensure that the distribution environment host can clone the repository.

Test Methods:

```
$ git clone <your-git-url>
```

Make sure to clone the code

Prepare postgresql

```
# apt-get install -y postgresql libpq-dev
```

postgresql user settings

(The easiest way is to change the md5 and peer in `/etc/postgresql/9.3/main/pg_hba.conf` to trust.)

Then restart postgresql

```
# service postgresql restart
```

Install redis

```
# apt-get install redis-server
```

Install nodejs (used to compile assets)

```
# curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash-
# apt-get install -y nodejs
```

Install yarn (used to compile webpacker)

```
# curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add-
# echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# apt-get update
# apt-get install -y yarn
```


> In order to ensure that the action cable can work correctly, it needs nginx version no less than 1.9
nginx installation and configuration

```
# add-apt-repository ppa:nginx/stable
# apt-get update
# apt-get install nginx
# nginx -v (> 1.9)
# cp /data/www/xxx/current/config/nginx.conf.example /etc/nginx/conf.d/xxx.conf
```
Adjust the server_name inside to point to your own domain name

```
# nginx -s reload
```

Open `http://yourserverdomain` in the local browser to check whether the publication is successful.

# Other best practices

## Server Security

We use ufw as a firewall, simple and safe.

ufw configuration, open `22`, `80`, `443` ports

```
# ufw allow 22/tcp
# ufw allow 80/tcp
# ufw allow 443/tcp
# ufw enable
```
In this way, most intrusions can be prevented.

## CDN configuration

CDN can greatly accelerate the access speed of the application.After using a CDN service (such as Paiyun or Qiniuyun), get the CDN address after returning to the source.

The online application.yml configuration is as follows:

```
CDN:''
```

Recompile assets

```
$ cd /data/www/xxx/current
```

```
$ RAILS_ENV=production bundle exec rake assets:precompile
```

Refresh the page and check whether the static resources are displayed correctly.

## monit monitoring

```
# apt-get install monit
# cp /data/www/xxx/current/config/monit.conf.example /etc/monit/conf.d/xxx.conf
```

## logrotate log split

Rails-template integrates a log splitting tool by default to ensure that the log will not increase indefinitely during long-term operation. The default configuration logic is to cut a copy every day and keep the logs for the last seven days.

```
# cp /data/www/xxx/current/config/logrotate.conf.example /etc/logrotate.d/xxx
```

have a test
```
# logrotate -f /etc/logrotate.d/xxx
```

If there is a security issue, please add `su ruby ruby` to the configuration and try again.

## Connection limit

If your application uses actioncable, you must ensure that the number of connections supports limit opening. Use

```
$ ulimit -Sn
$ ulimit -Hn
```

To check. The output values should be set to `65535`. If not, please modify the `limits.conf` configuration.

```
# vi /etc/security/limits.conf
```

Add the following

```
root soft nofile 65535
root hard nofile 65535
* soft nofile 65535
* hard nofile 65535
```
Then use the above command to check the output again to ensure success.
