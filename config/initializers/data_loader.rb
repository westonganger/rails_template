raw_settings = File.read(Rails.root.join("data/site.yml"))
SITE_DATA = YAML.load(raw_settings)[Rails.env].with_indifferent_access
