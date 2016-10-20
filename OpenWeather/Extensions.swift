//
//  Extensions.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/18/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import Foundation
import MapKit

extension CLLocation {
    func weatherQueryURL() -> URL? {
        guard let components = NSURLComponents(string: "http://api.openweathermap.org/data/2.5/weather") else { return nil }
        components.queryItems = [
            URLQueryItem(name: "APPID", value: "23ad7d0aeb77de4a1f31d728feed84a1"),
            URLQueryItem(name: "lat", value: String(self.coordinate.latitude)),
            URLQueryItem(name: "lon", value: String(self.coordinate.longitude))
        ]
        return components.url
    }
}

extension Data {
    func serializeData() -> WeatherData? {
        do {
            guard let weather = try JSONSerialization.jsonObject(with: self, options: []) as? [String: AnyObject] else { return nil }
            var weatherData = WeatherData()
            weatherData.name = weather["name"] as? String
            if let mainDictionary = weather["main"] { weatherData.temperature = mainDictionary["temp"] as? Double }
            if let weatherDictionary = weather["weather"]?.firstObject as? [String:AnyObject] {
                weatherData.description = weatherDictionary["description"] as? String
                weatherData.icon = weatherDictionary["icon"] as? String
            }
            return weatherData
        } catch { return nil }
    }
}

extension Double {
    private func temperatureInCelsius() -> Double {
        return self - 273.15
    }

    private func temperatureInFahrenheit() -> Double {
        return (9/5) * (self - 273.15) + 32
    }

    func toTemperatureDisplayString(unit: TemperatureUnit) -> String {
        switch(unit) {
        case .Celsius:
            return String(describing: Int(self.temperatureInCelsius().rounded())) + "°C"
        case .Fahrenheit:
            return String(describing: Int(self.temperatureInFahrenheit().rounded())) + "°F"
        }
    }
}

extension String {
    func weatherIconImageName() -> String? {
        switch(self) {
            case "01d": return "clear-day"
            case "01n": return "clear-night"
            case "02d": return "partly-cloudy-day"
            case "02n": return "partly-cloudy-night"
            case "03d": fallthrough
            case "03n": fallthrough
            case "04d": fallthrough
            case "04n": return "cloudy"
            case "09d": fallthrough
            case "09n": fallthrough
            case "10d": fallthrough
            case "10n": fallthrough
            case "11d": fallthrough
            case "11n": return "rain"
            case "13d": fallthrough
            case "13n": return "snow"
            case "50d": fallthrough
            case "50n": return "fog"
            default: return nil
        }
    }
}
