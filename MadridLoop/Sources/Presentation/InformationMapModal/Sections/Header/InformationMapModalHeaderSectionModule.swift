//
//  InformationMapModalHeaderSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class InformationMapModalHeaderSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any InformationMapModalHeaderSectionMapperContract).self,
                                            InformationMapModalHeaderSectionMapper.self)
    }
}
