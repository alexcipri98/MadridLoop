//
//  GetVersionUseCase.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 11/8/25.
//

import CoreLocation
import DependencyInjector

// MARK: - Parámetros del use case

open class GetVersionUseCaseParameters {
    public init() {}
}

// MARK: - Protocolo del use case

public protocol GetVersionUseCaseContract: Instanciable {
    func run(_ parameters: GetVersionUseCaseParameters) async throws -> VersionModel
}

// MARK: - Implementación

open class GetVersionUseCase: GetVersionUseCaseContract {
    public let getVersionRepository: GetVersionRepositoryContract
    
    required public init() {
        @Injected var getVersionRepository: GetVersionRepositoryContract
        self.getVersionRepository = getVersionRepository
    }
    
    public func run(_ parameters: GetVersionUseCaseParameters) async throws -> VersionModel {
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
        return try await getVersionRepository.getVersion(version: currentVersion)
    }
}
