//
//  OWLocationManager.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import MapKit

protocol OWLocationManagerDelegate : class {
    func didUpdate(location: CLLocation)
}

final class OWLocationManager : NSObject {
    private let manager = CLLocationManager()
    weak var delegate : OWLocationManagerDelegate?

    /*  The userLocation instance variable is used to detect whether a location has already been
        updated from a call to requestLocation().  There seems to be a bug where
        CLLocationManager.requestLocation() would make multiple calls to didUpdateLocations()
        despite the documentation specifying that the call would only be made once.
    */
    var userLocation: CLLocation?

    static let sharedInstance : OWLocationManager = {
        let instance = OWLocationManager()
        return instance
    }()

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestLocation() {
        userLocation = nil
        checkAuthorizationStatus()
        manager.requestLocation()
    }

    private func checkAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
}

extension OWLocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, userLocation == nil {
            userLocation = location
            delegate?.didUpdate(location: location)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
