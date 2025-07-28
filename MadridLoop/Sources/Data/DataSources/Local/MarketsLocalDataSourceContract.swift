//
//  MarketsLocalDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 27/7/25.
//

import Foundation
import DependencyInjector

public protocol MarketsLocalDataSourceContract: Instanciable {
    func getCachedMarkets() async throws -> [MarketInformationModel]?
    func saveMarkets(_ events: [MarketInformationModel]) async throws
    func cleanMarketsCache() async
}
