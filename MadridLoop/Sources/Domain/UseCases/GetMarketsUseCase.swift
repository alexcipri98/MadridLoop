//
//  GetMarketsUseCase.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import CoreLocation
import DependencyInjector

// MARK: - Parámetros del use case

open class GetMarketsUseCaseParameters {
    public init() {}
}

// MARK: - Protocolo del use case

public protocol GetMarketsUseCaseContract: Instanciable {
    func run(_ parameters: GetMarketsUseCaseParameters) async throws -> [MarketInformationModel]
}

// MARK: - Implementación

open class GetMarketsUseCase: GetMarketsUseCaseContract {
    public let repository: GetMarketsInformationRepositoryContract

    required public init() {
        @Injected var repository: GetMarketsInformationRepositoryContract
        self.repository = repository
    }
    
    open func run(_ parameters: GetMarketsUseCaseParameters) async throws -> [MarketInformationModel] {
        let response = try await repository.getMarketsInformation()
        return response
    }
}
