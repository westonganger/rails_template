raw_settings = File.read(Rails.root.join("config/site_data.yml"))
SITE_DATA = YAML.load(raw_settings)[Rails.env].symbolize_keys
