//
//  GetVersionRemoteDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 11/8/25.
//

import DependencyInjector

public protocol GetVersionRemoteDataSourceContract: Instanciable {
    func getVersion(version: String) async throws -> VersionEntity
}
