//
//  OpenWeatherTests.swift
//  OpenWeatherTests
//
//  Created by Philip Tseng on 10/19/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import XCTest
import MapKit

class OpenWeatherTests: XCTestCase {

    func testWeatherQueryURL() {
        let location = CLLocation(latitude: 50, longitude: -100)
        XCTAssertEqual(location.weatherQueryURL()?.absoluteString, "http://api.openweathermap.org/data/2.5/weather?APPID=23ad7d0aeb77de4a1f31d728feed84a1&lat=50.0&lon=-100.0")
    }

    func testOpenWeatherMapAPIDataSerialization() {
        let jsonText = "{\"coord\":{\"lon\":-122.68,\"lat\":45.52},\"weather\":[{\"id\":500,\"main\":\"Rain\",\"description\":\"light rain\",\"icon\":\"10d\"}],\"base\":\"stations\",\"main\":{\"temp\":284.96,\"pressure\":997.55,\"humidity\":99,\"temp_min\":284.96,\"temp_max\":284.96,\"sea_level\":1032.51,\"grnd_level\":997.55},\"wind\":{\"speed\":2.06,\"deg\":174.501},\"rain\":{\"3h\":1.815},\"clouds\":{\"all\":100},\"dt\":1476979861,\"sys\":{\"message\":0.0158,\"country\":\"US\",\"sunrise\":1476974127,\"sunset\":1477012461},\"id\":5746545,\"name\":\"Portland\",\"cod\":200}"
        let data = jsonText.data(using: .utf8)
        let weatherData = data?.serializeData()

        XCTAssertEqual(weatherData?.name, "Portland")
        XCTAssertEqual(weatherData?.description, "light rain")
        XCTAssertEqual(weatherData?.icon, "10d")
        XCTAssertEqual(weatherData?.temperature, 284.96)
    }

    func testKelvinToStringConversion() {
        XCTAssertEqual(280.0.toTemperatureDisplayString(unit: .Fahrenheit), "44°F")
        XCTAssertEqual(280.0.toTemperatureDisplayString(unit: .Celsius), "7°C")
    }
    
    func testWeatherIconImageName() {
        XCTAssertEqual("01d".weatherIconImageName(), "clear-day")
        XCTAssertEqual("01n".weatherIconImageName(), "clear-night")
        XCTAssertEqual("02d".weatherIconImageName(), "partly-cloudy-day")
        XCTAssertEqual("02n".weatherIconImageName(), "partly-cloudy-night")
        XCTAssertEqual("03d".weatherIconImageName(), "cloudy")
        XCTAssertEqual("03n".weatherIconImageName(), "cloudy")
        XCTAssertEqual("04d".weatherIconImageName(), "cloudy")
        XCTAssertEqual("04n".weatherIconImageName(), "cloudy")
        XCTAssertEqual("09d".weatherIconImageName(), "rain")
        XCTAssertEqual("09n".weatherIconImageName(), "rain")
        XCTAssertEqual("10d".weatherIconImageName(), "rain")
        XCTAssertEqual("10d".weatherIconImageName(), "rain")
        XCTAssertEqual("11d".weatherIconImageName(), "rain")
        XCTAssertEqual("11n".weatherIconImageName(), "rain")
        XCTAssertEqual("13d".weatherIconImageName(), "snow")
        XCTAssertEqual("13n".weatherIconImageName(), "snow")
        XCTAssertEqual("50d".weatherIconImageName(), "fog")
        XCTAssertEqual("50n".weatherIconImageName(), "fog")
        XCTAssertEqual("nonsense".weatherIconImageName(), nil)
    }
}
