require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinancialKit
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_paths += %W[#{config.root}/lib/modules]
    config.assets.precompile += %w[admin.scss application.scss emails.css]


    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")

    config.autoload_lib(ignore: %w[assets tasks generators])

    config.exceptions_app = self.routes

    config.boom_env = nil
    # Don't generate system test files.
    config.generators.system_tests = nil

    config.i18n.enforce_available_locales = false
    config.i18n.default_locale = :hr
    config.i18n.available_locales = [ :hr, :en, :de ]

    config.time_zone = "Zagreb"

    config.before_configuration do
      env_file = File.join(Rails.root, "config", "local_env.yml")
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exist?(env_file)
    end
  end
end
