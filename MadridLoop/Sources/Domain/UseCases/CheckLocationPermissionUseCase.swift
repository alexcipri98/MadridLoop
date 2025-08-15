//
//  GetPermissionLocation.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/8/25.
//

import CoreLocation
import DependencyInjector

// MARK: - Parámetros del use case
open class CheckLocationPermissionUseCaseParameters {
    public init() {}
}

// MARK: - Protocolo del use case
public protocol CheckLocationPermissionUseCaseContract: Instanciable {
    func run(_ parameters: CheckLocationPermissionUseCaseParameters) async -> Bool
}

// MARK: - Implementación
open class CheckLocationPermissionUseCase: CheckLocationPermissionUseCaseContract {
    
    required public init() {}
    
    open func run(_ parameters: CheckLocationPermissionUseCaseParameters) async -> Bool {
        let locationManager = CLLocationManager()
        let status: CLAuthorizationStatus

        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }

        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted, .notDetermined:
            return false
        @unknown default:
            return false
        }
    }
}
