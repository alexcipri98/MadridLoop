//
//  GetUserLocationUseCase.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import MapKit

open class GetUserLocationUseCaseParameters {
    public init() {}
}

public protocol GetUserLocationUseCaseContract: Instanciable {
    func run(_ parameters: GetUserLocationUseCaseParameters) -> CLLocationCoordinate2D?
}

class GetUserLocationUseCase: GetUserLocationUseCaseContract {
    private var locationManager: UserLocationManagerContract
#warning("Es posible que el hecho de usar el injector de dependencias haga que no se actualice la localización del usuario")
    required public init() {
        @Injected var locationManager: UserLocationManagerContract
        self.locationManager = locationManager
    }
    
    public func run(_ parameters: GetUserLocationUseCaseParameters) -> CLLocationCoordinate2D? {
        return locationManager.location
    }
}

