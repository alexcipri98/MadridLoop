//
//  DogsInformationLocalDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 27/7/25.
//

import Foundation
import DependencyInjector

public protocol DogsInformationLocalDataSourceContract: Instanciable {
    func getDogsInformation(distrit: String) async throws -> [DogsInformationModel]
    func addDogsInformation(_ dogsInformation: [DogsInformationModel])
    func cleanDogsInformationCache() async
}
