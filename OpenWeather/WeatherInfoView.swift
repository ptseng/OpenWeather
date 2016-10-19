//
//  WeatherInfoView.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    var temperatureInFahrenheit : Double?
    var temperatureInCelsius : Double?

    @IBOutlet weak var cityName : UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDescription : UILabel!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var unitSegmentedControl : UISegmentedControl!
    @IBAction func temperatureUnitChanged(sender: UISegmentedControl) { setTemperatureDisplay() }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func clearWeatherInfo() {
        unitSegmentedControl.isHidden = true
        cityName.text = "--"
        weatherIcon.image = nil
        weatherDescription.text = "--"
        temperatureLabel.text = "--"
    }

    func setWeatherInfo(for weatherData: WeatherData) {
        unitSegmentedControl.isHidden = false
        if let iconName = weatherData.icon?.weatherIconImageName() {
            weatherIcon.image = UIImage(named: iconName)
        }
        cityName.text = weatherData.name
        weatherDescription.text = weatherData.description
        temperatureInCelsius = weatherData.temperatureInCelsius()
        temperatureInFahrenheit = weatherData.temperatureInFahrenheit()
        setTemperatureDisplay()
    }

    private func setTemperatureDisplay() {
        switch(unitSegmentedControl.selectedSegmentIndex) {
        case 0:
            if let roundedTemperature = temperatureInCelsius?.rounded() {
                temperatureLabel.text = String(describing: Int(roundedTemperature)) + "°C"
            }
        case 1:
            if let roundedTemperature = temperatureInFahrenheit?.rounded() {
                temperatureLabel.text = String(describing: Int(roundedTemperature)) + "°F"
            }
        default:
            break
        }
    }
}
