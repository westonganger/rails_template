# encoding: utf-8
## backup gem example
## Howto:
## $ gem install backup
## $ backup generate:model --trigger my_app_name --archives --storages='local' --compressor='gzip'
## $ cp config/backup.rb.example ~/Backup/models/my_app_name.rb
## $ backup perform --trigger my_app_name

Model.new(:my_app_name, 'Description for my_app_name') do

  database PostgreSQL do |db|
    db.name               = "my_app_name_production"
    db.username           = "postgres"
    db.password           = "postgres"
    db.host               = "localhost"
    db.port               = 5432
  end

  archive :rails_config do |archive|
    archive.add "/data/www/my_app_name/shared/config/"
    archive.add "/etc/nginx/conf.d/"
  end

  store_with Local do |local|
    local.path       = "/data/www/backups/"
    local.keep       = 5
  end

  # Use FTP instead of Local in production environments
  #store_with FTP do |server|
    #server.username     = ""
    #server.password     = ""
    #server.ip           = ""
    #server.port         = 21
    #server.path         = "~/backups/"
    #server.keep         = 5
    ## server.keep         = Time.now - 2592000 # Remove all backups older than 1 month.
    #server.passive_mode = false
  #end

  compress_with Gzip
end
