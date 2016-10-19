//
//  Extensions.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/18/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

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
