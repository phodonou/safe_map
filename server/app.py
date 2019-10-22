from flask import Flask
from flask_restful import Api, reqparse

from resources.danger_locations import DangerLocations
from resources.danger_feed import DangerFeed
from resources.danger_twilio import DangerTwilio
from resources.main import Main

app = Flask(__name__)
api = Api(app)

api.add_resource(Main, "/")
api.add_resource(DangerLocations, "/danger_locations")
api.add_resource(DangerFeed, "/danger_feed")
api.add_resource(DangerTwilio, "/danger_twilio" )

if __name__ == "__main__":
  app.run()