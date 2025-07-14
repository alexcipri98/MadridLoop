//
//  LandingEventSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LandingEventSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any LandingEventSectionMapperContract).self,
                                            LandingEventSectionMapper.self)
    }
}
