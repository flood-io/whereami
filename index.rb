require 'sinatra'
require 'geocoder'
require 'httparty'
require 'json'
require 'uri'

post '/' do
  token = ENV['TOKEN']
  user_id = params['user_id']

  user_response = HTTParty.get("https://slack.com/api/users.info?token=#{token}&user=#{user_id}&include_locale=true")
  user = JSON.parse(user_response.body)['user']

  time_zone = user['tz_label']
  geo = Geocoder.search(time_zone.gsub('time', ''))
  country = geo.first.country
  country_code = geo.first.country_code

  profile = {
    status_text: time_zone,
    status_emoji: ":flag-#{country_code.downcase}:"
  }.to_json

  HTTParty.post("https://slack.com/api/users.profile.set?token=#{token}&user=#{user_id}&profile=#{URI::encode(profile)}")

  "Looks like you are in :flag-#{country_code.downcase}: #{country} on #{time_zone}"
end
