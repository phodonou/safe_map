from flask_restful import Resource
import gunicorn
import json
import requests
from flask_restful import reqparse
from resources.helpers.send_twilio import crime_in_location
from resources.helpers.get_crime import get_crime_feed

#https://[heroku_url]/danger_twilio?lon=-87.627215&lat=41.877592&to=13124785453
parser = reqparse.RequestParser()
parser.add_argument('lat', type=float)
parser.add_argument('lon', type=float)
parser.add_argument('to', type=str)

class DangerTwilio(Resource):
  def get(self):
    args = parser.parse_args()
    lat = args['lat']
    lon = args['lon']
    to = args['to']
    crimes = get_crime_feed(lat, lon, radius=0.0001)
    crime_in_location(to, crimes, stop=2)
    return {'success': 200}