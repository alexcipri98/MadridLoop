//
//  LandingMarketsSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LandingMarketsSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any LandingMarketsSectionMapperContract).self,
                                            LandingMarketsSectionMapper.self)
    }
}
