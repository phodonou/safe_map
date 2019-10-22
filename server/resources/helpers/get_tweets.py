from TwitterAPI import TwitterAPI
from TwitterAPI import TwitterPager

consumer_key = '[Twitter Consumer Key]'
consumer_secret = '[Twitter Consumer Secret]'
access_token_key = '[Twitter Access Token Key]'
access_token_secret = '[Twitter Access Token Secret]'

#Really dumb way of looking for Twitter crimes
array_of_crimes = [
    'rson',
    'kill',
    'dying',
    'shooting',
    'shoot',
    'assault',
    'bigamy',
    'blackmail',
    'bribery',
    'burglary',
    'child abuse',
    'conspiracy',
    'espionage',
    'forgery',
    'fraud',
    'genocide',
    'hijacking',
    'homicide',
    'kidnapping',
    'manslaughter',
    'mugging',
    'murder',
    'perjury',
    'rape',
    'riot',
    'robbery',
    'shoplifting',
    'slander',
    'smuggling',
    'treason',
    'trespassing',
    'robery',
    'robed',
    'dead',
    'dangerous',
    'stay away',
    'run away',
    'stolen',
    'kidnap',
    'missing child',
    'missing kid',
    'abuse',
    'child abuse',
    'abduction',
    'stabbing',
    'stabs',
    'stalking', 
    'stalker',
    'unsafe',
    'racist'
]

api = TwitterAPI(consumer_key, consumer_secret, access_token_key, access_token_secret)

def get_crime_tweets(lat, lon, radius_str):
#radius example => 5mi
    result_array = []
    try:
        all_tweets = api.request('search/tweets', {'geocode':'{0},{1},{2}'.format(lat, lon, radius_str)})
    except Exception:
        return []
        for tweet in all_tweets:
            msg = tweet['text']
            word = isCrimeTweet(msg)
            if(word):
                try:
                    tweet_lat = tweet['coordinates']['coordinates'][1]
                    tweet_lon = tweet['coordinates']['coordinates'][0]
                except Exception:
                    tweet_lat = lat
                    tweet_lon = lon
                date = tweet['created_at']
                new_dict = {'lat':tweet_lat,'lon':tweet_lon,'crime':word}
                result_array.append(new_dict)
    return result_array

def get_crime_feed_tweets(lat, lon):
#radius example => 5mi
    result_array = []
    try:
        all_tweets = api.request('search/tweets', {'geocode':'{0},{1},{2}'.format(lat, lon, '10mi')})
        for tweet in all_tweets:
            msg = tweet['text']
            if(isCrimeTweet(msg)):
                date = tweet['created_at']
                name = tweet['user']['screen_name']
                favorited_count = tweet['favorite_count']
                new_dict = {'message':msg,'date':date,'name':name, 'favorite_count':favorited_count}
                result_array.append(new_dict)
    except Exception:
        return []
    return result_array

def isCrimeTweet(text):
    for word in array_of_crimes:
        if word in text.lower():
            return word
    return None

