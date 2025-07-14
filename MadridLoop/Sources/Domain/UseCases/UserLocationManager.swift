//
//  UserLocationManager.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import MapKit

public protocol UserLocationManagerContract: Instanciable {
    var location: CLLocationCoordinate2D? { get }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
}

open class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, UserLocationManagerContract {
    private var locationManager = CLLocationManager()
    
    public var location: CLLocationCoordinate2D?
    
    required public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    open func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    open func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error de ubicación: \(error.localizedDescription)")
    }
}
