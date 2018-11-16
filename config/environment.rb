ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)

require "bundler/setup" if File.exists?(ENV["BUNDLE_GEMFILE"])
require "rubygems"

require "active_record"
require "erb"
require "logger"
require "pathname"
require "pg"
require "sinatra"

# Timezone Settings
ActiveRecord::Base.default_timezone = :local
Time.zone = "Pacific Time (US & Canada)"

APP_ROOT = Pathname.new(File.expand_path("../../", __FILE__))
APP_NAME = APP_ROOT.basename.to_s

Dir[APP_ROOT.join("app", "controllers", "*.rb")].each { |file| require file }

require APP_ROOT.join("config", "database")
