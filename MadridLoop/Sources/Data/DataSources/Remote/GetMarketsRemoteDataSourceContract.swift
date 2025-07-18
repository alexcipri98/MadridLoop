//
//  GetMarketsRemoteDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import DependencyInjector

public protocol GetMarketsRemoteDataSourceContract: Instanciable {
    func getMarkets() async throws -> MarketsEntity
}
