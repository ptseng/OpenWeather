#OpenWeather

OpenWeather is a minimum viable product (MVP) app that displays the weather in your current location.

## User Story and Acceptance Criteria

<b>User Story:</b> As an outdoor person and traveler, I want to know the day's weather forecast so that I can dress appropriately.

<b>Acceptance Criteria:</b> Can I see today's weather forecast for my current location?

## Features

1. Determines the user's location once.
2. Displays a map of the user's location.
3. Makes a single network call to the OpenWeatherMap API to fetch weather information based on the user's location.
4. Displays to the user their city's name, current temperature, weather description, and an icon representing the current weather.
5. Allows user to switch temperature units between Celsius and Fahrenheit.
6. Every time the app enters the background and becomes active again, weather data will be refreshed.

## Tests

### On First Launch
#### Location Permissions Disabled
1. Map is zoomed out to encompass the entire United States.
2. Displays the empty weather state.

#### Location Permissions Enabled, No Network Connection
1. Map is zoomed to current location.
2. Displays the empty weather state.

#### Location Permissions Enabled, With Network Connection
1. Map is zoomed to current location.
2. Weather is displayed for current location.

### On Subsequent Launches With Initial Load of Weather Data

#### Location Permissions Disabled
1. Map is still zoomed in to current location.
2. Current location indicator disappears.
3. Weather is still displayed for current location.

#### Location Permissions Enabled, No Network Connection
1. Current location indicator reappears.
2. Map is still zoomed in to current location.
3. Weather is still displayed for current location.

#### Location Permissions Enabled, With Network Connection
1. Map is still zoomed in to current location.
2. Current location indicator is still showing.
3. Weather is still  displayed for current location.

## Third Party Dependencies

The app does not use any third-party dependencies.  Weather icons used were taken from the [Tropos iOS App](https://github.com/thoughtbot/Tropos).

## Build/Run Instructions

OpenWeather is written in Swift 3.0 using XCode 8 and the iOS 10 SDK.  Since there are no third party dependencies just build and run using XCode.

## Design Patterns

OpenWeather is a single page app using a single ViewController and Storyboard.  

The are two singleton classes.  OWLocationManager is a singleton class that handles all requests for the user's current location.  OWNetworkManager is a singleton class that handles all network requests to the OpenWeatherMap API.

The delegation pattern is used to notify the ViewController whenever there is new location or weather data from the singleton classes.  When a new location is received, the map will zoom to that location and trigger a network call to fetch weather data using OWNetworkManager.  Once new weather data is received it will be fed into WeatherInfoView to update display using that data.


 
