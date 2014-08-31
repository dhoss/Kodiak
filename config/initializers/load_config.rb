CONFIG_PATH="#{Rails.root}/config/app.yml"
APP_CONFIG = YAML.load_file(CONFIG_PATH)[Rails.env]
