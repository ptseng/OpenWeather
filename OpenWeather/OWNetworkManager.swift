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

    func fetchWeatherData(for location: CLLocation) {
        guard let url = location.weatherQueryURL() else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            guard let weatherData = responseData.serializeData() else { return }
            DispatchQueue.main.async { self.delegate?.didFetch(weatherData: weatherData) }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
}
