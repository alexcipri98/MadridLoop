//
//  UserLocationManager.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Combine
import DependencyInjector
import MapKit

public protocol UserLocationManagerContract: Instanciable {
    var locationPublisher: AnyPublisher<CLLocationCoordinate2D?, Never> { get }
    var locationErrorPublisher: AnyPublisher<Error, Never> { get }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    func waitForLocation() async throws -> CLLocationCoordinate2D
}

open class UserLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate, UserLocationManagerContract {
    private var locationManager = CLLocationManager()
    
    @Published public var location: CLLocationCoordinate2D?
    @Published private var locationError: Error?

    public var locationPublisher: AnyPublisher<CLLocationCoordinate2D?, Never> {
        $location.eraseToAnyPublisher()
    }
    
    public var locationErrorPublisher: AnyPublisher<Error, Never> {
        $locationError.compactMap { $0 }.eraseToAnyPublisher()
    }

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
        locationError = error
    }

    public func waitForLocation() async throws -> CLLocationCoordinate2D {
        for try await location in $location.values {
            if let validLocation = location {
                return validLocation
            }
        }
        throw NSError(domain: "UserLocationManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener la ubicación."])
    }
}
