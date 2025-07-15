//
//  InformationMapModalContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class InformationMapModalContentSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any InformationMapModalContentSectionMapperContract).self,
                                            InformationMapModalContentSectionMapper.self)
    }
}
