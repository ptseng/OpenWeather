//
//  OWNetworkManager.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import MapKit

protocol OWNetworkManagerDelegate : class {
    func didFetch(weatherData: WeatherData)
}

final class OWNetworkManager : NSObject {
    weak var delegate : OWNetworkManagerDelegate?

    static let sharedInstance : OWNetworkManager = {
        let instance = OWNetworkManager()
        return instance
    }()

    private func weatherQueryURL(for location : CLLocation) -> URL? {
        guard let components = NSURLComponents(string: "http://api.openweathermap.org/data/2.5/weather") else { return nil }
        components.queryItems = [
            URLQueryItem(name: "APPID", value: "23ad7d0aeb77de4a1f31d728feed84a1"),
            URLQueryItem(name: "lat", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "lon", value: String(location.coordinate.longitude))
        ]
        return components.url
    }

    func fetchWeatherData(for location : CLLocation) {
        guard let url = weatherQueryURL(for: location) else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            do {
                guard let weather = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else { return }
                var weatherData = WeatherData()
                weatherData.name = weather["name"] as? String
                if let mainDictionary = weather["main"] { weatherData.temperature = mainDictionary["temp"] as? Double }
                if let weatherDictionary = weather["weather"]?.firstObject as? [String:AnyObject] {
                    weatherData.description = weatherDictionary["description"] as? String
                    weatherData.icon = weatherDictionary["icon"] as? String
                }
                DispatchQueue.main.async { self.delegate?.didFetch(weatherData: weatherData) }
            } catch { return }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
