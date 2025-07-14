//
//  LandingHeaderSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LandingHeaderSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any LandingHeaderSectionMapperContract).self,
                                            LandingHeaderSectionMapper.self)
    }
}
