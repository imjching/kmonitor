# This script fetches data for all the users in the database.
#
# We will send a request to Kattis and attempt to record both the score and rank
# for the users that we track.

require ::File.expand_path("../../config/environment",  __FILE__)

require 'httparty'
require 'nokogiri'

BASE_URL = "https://open.kattis.com/users"

User.find_each do |user|
  doc = User.fetch_page(user.name)
  User.store_kattis_data(user, doc)
end
