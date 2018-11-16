require "httparty"
require "nokogiri"

class User < ActiveRecord::Base
  has_many :progress_entries

  validates :name, uniqueness: true, presence: true

  BASE_URL = "https://open.kattis.com/users"

  def self.fetch_page(username)
    doc = HTTParty.get("#{BASE_URL}/#{username}")
    raise "Invalid username" unless doc.code == 200
    doc
  end

  def self.store_kattis_data(user, doc)
    base = Nokogiri::HTML(doc)
    result = base
      .css(".score_wrapper .rank table td")
      .children.map { |value| value.text.strip.downcase }

    raise "Internal server error" if result[0] != "rank" || result[1] != "score" # Problematic!

    user.progress_entries.create(
      rank: result[2].to_i,
      score: result[3].to_f
    )
  end
end
