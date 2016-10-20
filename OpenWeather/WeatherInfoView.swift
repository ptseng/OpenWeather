//
//  WeatherInfoView.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import UIKit

class WeatherInfoView: UIView {

    var temperatureInKelvin : Double?

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
        temperatureInKelvin = weatherData.temperature
        setTemperatureDisplay()
    }

    private func setTemperatureDisplay() {
        switch(unitSegmentedControl.selectedSegmentIndex) {
        case 0:
            if let temp = temperatureInKelvin {
                temperatureLabel.text = temp.toTemperatureDisplayString(unit: .Celsius)
            }
        case 1:
            if let temp = temperatureInKelvin {
                temperatureLabel.text = temp.toTemperatureDisplayString(unit: .Fahrenheit)
            }
        default:
            break
        }
    }
}
