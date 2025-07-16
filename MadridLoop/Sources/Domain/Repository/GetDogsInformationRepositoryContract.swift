//
//  GetDogsInformationRepositoryContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import DependencyInjector

public protocol GetDogsInformationRepositoryContract: Instanciable {
    func getDogsInformation(postalCode: String) async throws -> [DogsInformationModel]
}
