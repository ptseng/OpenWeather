//
//  ViewController.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var weatherInfoView: WeatherInfoView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "OpenWeather"

        OWLocationManager.sharedInstance.delegate = self
        OWNetworkManager.sharedInstance.delegate = self
        OWLocationManager.sharedInstance.requestLocation()

        mapView.showsUserLocation = true
        mapView.isRotateEnabled = false
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false

        weatherInfoView.alpha = 0.95
        weatherInfoView.layer.cornerRadius = 9
        weatherInfoView.layer.masksToBounds = true
        weatherInfoView.clearWeatherInfo()
    }

    func zoomMap(to location: CLLocation) {
        let span = MKCoordinateSpanMake(0.2, 0.2)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController : OWLocationManagerDelegate {
    func didUpdate(location: CLLocation) {
        zoomMap(to: location)
        OWNetworkManager.sharedInstance.fetchWeatherData(for: location)
    }
}

extension ViewController : OWNetworkManagerDelegate {
    func didFetch(weatherData: WeatherData) {
        weatherInfoView.setWeatherInfo(for: weatherData)
    }
}
