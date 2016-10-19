//
//  WeatherData.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/18/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

struct WeatherData {
    var name : String?
    var temperature : Double?
    var description : String?
    var icon : String?
}

extension WeatherData {
    func temperatureInCelsius() -> Double? {
        guard let temp = temperature else { return nil }
        return temp - 273.15
    }

    func temperatureInFahrenheit() -> Double? {
        guard let temp = temperature else { return nil }
        return (9/5) * (temp - 273.15) + 32
    }
}
