from flask_restful import Resource
import gunicorn
import json
import requests
from flask_restful import reqparse
from resources.helpers.get_crime import get_crime_feed
from resources.helpers.get_tweets import get_crime_tweets


#https://[heroku_url]/danger_locations?lon=12.32421&lat=14.321321
parser = reqparse.RequestParser()
parser.add_argument('lat', type=float)
parser.add_argument('lon', type=float)

class DangerLocations(Resource):
  def get(self):
    args = parser.parse_args()
    lat = args['lat']
    lon = args['lon']
    crimes = get_crime_feed(lat, lon, radius=0.01)
    tweet_crimes = get_crime_tweets(lat, lon, radius_str='5mi')
    city_crimes = {'crimes': crimes + tweet_crimes}
    return city_crimes
    return "No crime in your area?!", 404