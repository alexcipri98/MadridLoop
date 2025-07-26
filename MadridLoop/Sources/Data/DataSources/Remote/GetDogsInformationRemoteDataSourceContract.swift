//
//  GetDogsInformationRemoteDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 15/7/25.
//

import DependencyInjector

public protocol GetDogsInformationRemoteDataSourceContract: Instanciable {
    func getDogsTrashInformation(distrit: String) async throws -> DogTrashEntity
    func getDogsFonts(district: String) async throws -> DogsFontsEntity
    func getNormalFonts(district: String) async throws -> NormalFontsEntity
}
