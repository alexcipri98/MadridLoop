//
//  MapContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class MapFiltersSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any MapFiltersSectionMapperContract).self,
                                            MapFiltersSectionMapper.self)
    }
}
