# Deployment Instructions

## Setup

First ensure the server is setup

Next run on the local host: 

```
mina setup
```

According to the prompt, go to the server to modify the corresponding configurations `application.yml` and `database.yml`

## Deploy

After adjusting the configuration of `config/deploy/production.rb`, you can start the first release.

The release task will often fail for the first time, in order to facilitate debugging and tracking, you can first smoke

```
mina first_deploy
```

If all goes well, enter the official release process.

```
$ mina deploy
```
