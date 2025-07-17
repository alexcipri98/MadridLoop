//
//  GetUserDistritUseCaseParameters.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import CoreLocation
import DependencyInjector

// MARK: - Parámetros del use case

open class GetUserDistritUseCaseParameters {
    public init() {}
}

// MARK: - Protocolo del use case

public protocol GetUserDistritUseCaseContract: Instanciable {
    func run(_ parameters: GetUserDistritUseCaseParameters) async throws -> String
}

// MARK: - Implementación

open class GetUserDistritUseCase: GetUserDistritUseCaseContract {
    private let locationManager: UserLocationManagerContract
    
    required public init() {
        @Injected var locationManager: UserLocationManagerContract
        self.locationManager = locationManager
    }
    
    public func run(_ parameters: GetUserDistritUseCaseParameters) async throws -> String {
        let coordinate = try await locationManager.waitForLocation()
        let postalCode = try await reverseGeocode(location: coordinate)
        if let distrit = distritFromPostalCode(postalCode) {
            return distrit
        } else {
            let error = NSError(domain: "GetUserDistritUseCase",
                                code: 1,
                                userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener el distrito para el código postal \(postalCode)."])
            throw error
        }
    }
}

private extension GetUserDistritUseCase {
    func reverseGeocode(location: CLLocationCoordinate2D) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            let geocoder = CLGeocoder()
            let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)

            geocoder.reverseGeocodeLocation(clLocation) { placemarks, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let postalCode = placemarks?.first?.postalCode {
                    continuation.resume(returning: postalCode)
                } else {
                    let fallbackError = NSError(
                        domain: "GetUserDistritUseCase",
                        code: 0,
                        userInfo: [NSLocalizedDescriptionKey: "No se pudo obtener el código postal."]
                    )
                    continuation.resume(throwing: fallbackError)
                }
            }
        }
    }
    
    func distritFromPostalCode(_ postalCode: String) -> String? {
        let mapaDistritos: [String: String] = [
            "28001": "SALAMANCA",
            "28002": "CHAMARTÍN",
            "28003": "CHAMBERÍ",
            "28004": "CENTRO",
            "28005": "CENTRO",
            "28006": "SALAMANCA",
            "28007": "RETIRO",
            "28008": "MONCLOA-ARAVACA",
            "28009": "RETIRO",
            "28010": "CHAMBERÍ",
            "28011": "LATINA",
            "28012": "CENTRO",
            "28013": "CENTRO",
            "28014": "RETIRO",
            "28015": "CENTRO",
            "28016": "CHAMARTÍN",
            "28017": "CIUDAD LINEAL",
            "28018": "PUENTE DE VALLECAS",
            "28019": "CARABANCHEL",
            "28020": "TETUÁN",
            "28021": "VILLAVERDE",
            "28022": "SAN BLAS-CANILLEJAS",
            "28023": "MONCLOA-ARAVACA",
            "28024": "LATINA",
            "28025": "CARABANCHEL",
            "28026": "USERA",
            "28027": "CIUDAD LINEAL",
            "28028": "SALAMANCA",
            "28029": "TETUÁN",
            "28030": "MORATALAZ",
            "28031": "VILLA DE VALLECAS",
            "28032": "VICÁLVARO",
            "28033": "HORTALEZA",
            "28034": "FUENCARRAL-EL PARDO",
            "28035": "MONCLOA-ARAVACA",
            "28036": "CHAMARTÍN",
            "28037": "SAN BLAS-CANILLEJAS",
            "28038": "PUENTE DE VALLECAS",
            "28039": "TETUÁN",
            "28040": "MONCLOA-ARAVACA",
            "28041": "VILLAVERDE",
            "28042": "BARAJAS",
            "28043": "HORTALEZA",
            "28044": "LATINA",
            "28045": "ARGANZUELA",
            "28046": "CHAMARTÍN",
            "28047": "LATINA",
            "28048": "FUENCARRAL-EL PARDO",
            "28049": "FUENCARRAL-EL PARDO",
            "28050": "HORTALEZA",
            "28051": "VILLA DE VALLECAS",
            "28052": "VICÁLVARO",
            "28053": "PUENTE DE VALLECAS",
            "28054": "USERA"
        ]
        
        return mapaDistritos[postalCode]
    }
}
