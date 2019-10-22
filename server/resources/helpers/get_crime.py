import requests


url = 'https://raw.githubusercontent.com/MertArm/safe_map/master/Crime_CSV2Json/crimes.json'


def get_crime_json(lat, lon, radius):
    r = requests.get(url = url)
    data = r.json()['crimes']
    filtered_data = []
    for crime in data:
        try:
            crime_lon = float(crime['LONGITUDE']) 
            crime_lat = float(crime['LATITUDE'])
        except Exception:
            continue 
        # Note the crime_lat and crime_lon are swapped --> data problem
        if((lon - radius)  <= crime_lat <= (lon + radius)):
            if((lat - radius) <= crime_lon <= (lat + radius)):
                new_dict = {'lat':crime_lon, 'lon':crime_lat,'crime':crime[' PRIMARY DESCRIPTION']}
                filtered_data.append(new_dict)
    return filtered_data

def get_crime_feed(lat, lon, radius):
    r = requests.get(url = url)
    data = r.json()['crimes']
    filtered_data = []
    for crime in data:
        try:
            crime_lon = float(crime['LONGITUDE']) 
            crime_lat = float(crime['LATITUDE'])
        except Exception:
            continue 
        # Note the crime_lat and crime_lon are swapped --> data problem
        if((lon - radius)  <= crime_lat <= (lon + radius)):
            if((lat - radius) <= crime_lon <= (lat + radius)):
                new_dict = {'name':'Chicago Public Reports',  'date':crime['DATE  OF OCCURRENCE'], 'message':crime[' PRIMARY DESCRIPTION'],  'favorite_count': 0}
                filtered_data.append(new_dict)
    return filtered_data
