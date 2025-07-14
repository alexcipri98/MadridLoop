//
//  MapContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class MapContentSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any MapContentSectionMapperContract).self,
                                            MapContentSectionMapper.self)
    }
}
