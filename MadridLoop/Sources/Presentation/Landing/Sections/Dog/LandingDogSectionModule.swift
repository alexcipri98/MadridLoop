//
//  LandingDogSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LandingDogSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any LandingDogSectionMapperContract).self,
                                            LandingDogSectionMapper.self)
    }
}
