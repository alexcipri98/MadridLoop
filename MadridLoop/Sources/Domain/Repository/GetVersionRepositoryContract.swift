//
//  GetVersionRepositoryContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 11/8/25.
//

import DependencyInjector

public protocol GetVersionRepositoryContract: Instanciable {
    func getVersion(version: String) async throws -> VersionModel
}

