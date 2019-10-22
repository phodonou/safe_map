from flask_restful import Resource
import gunicorn
import json
import requests
from flask_restful import reqparse
from resources.helpers.get_tweets import get_crime_feed_tweets
from resources.helpers.get_crime import get_crime_feed

parser = reqparse.RequestParser()
parser.add_argument('lat', type=float)
parser.add_argument('lon', type=float)

#https://[heroku_url]/danger_feed?lon=12.32421&lat=14.321321
class DangerFeed(Resource):
  def get(self):
    args = parser.parse_args()
    lat = args['lat']
    lon = args['lon']
    twitter_feed = get_crime_feed_tweets(lat, lon)
    crime_feed = get_crime_feed(lat, lon, radius=0.01)
    tweet_crimes = {'crimes': twitter_feed + crime_feed}
    return tweet_crimes
    return "The feed is empty", 404