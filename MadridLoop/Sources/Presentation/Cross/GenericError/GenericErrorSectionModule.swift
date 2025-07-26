//
//  GenericErrorSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class GenericErrorSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any GenericErrorSectionMapperContract).self,
                                            GenericErrorSectionMapper.self)
    }
}
