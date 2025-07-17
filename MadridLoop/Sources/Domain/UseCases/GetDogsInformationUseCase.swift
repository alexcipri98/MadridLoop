//
//  GetDogsInformationUseCase.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import DependencyInjector

open class GetDogsInformationUseCaseParameters {
    public let distrit: String

    public init(userPostalCode: String) {
        self.distrit = userPostalCode
    }
}

public protocol GetDogsInformationUseCaseContract: Instanciable {
    func run(_ parameters: GetDogsInformationUseCaseParameters) async throws -> [DogsInformationModel]
}

open class GetDogsInformationUseCase: GetDogsInformationUseCaseContract {
    public let repository: GetDogsInformationRepositoryContract

    required public init() {
        @Injected var repository: GetDogsInformationRepositoryContract
        self.repository = repository
    }
    
    open func run(_ parameters: GetDogsInformationUseCaseParameters) async throws -> [DogsInformationModel] {
        let response = try await repository.getDogsInformation(distrit: parameters.distrit)
        return response
    }
}
