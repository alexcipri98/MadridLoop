//
//  GetMarketsInformationRepositoryContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import DependencyInjector

public protocol GetMarketsInformationRepositoryContract: Instanciable {
    func getMarketsInformation() async throws -> [MarketInformationModel]
}
