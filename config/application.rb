require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # 6.0 => Zeitwerk(オートロードシステム)を有効にする
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Railsアプリデフォルトのタイムゾーン(default 'UTC')
    # TimeZoneList: http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html
    config.time_zone = ENV["TZ"]

    # データベースの読み書きに使用するタイムゾーン(:local | :utc(default))
    config.active_record.default_timezone = :utc

    # i18nで使われるデフォルトのロケールファイルの指定(default :en)
    config.i18n.default_locale = :ja

    # $LOAD_PATHにautoload pathを追加しない(Zeitwerk有効時false推奨)
    config.add_autoload_paths_to_load_path = false

    # Cookieを処理するmiddleware
    config.middleware.use ActionDispatch::Cookies

    # Cookiesのsamesite属性を変更する(本番環境: herokuにおける設定)
    # config.action_dispatch.cookies_same_site_protection =
    # ENV["COOKIES_SAME_SITE"].to_sym if Rails.env.production?

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
