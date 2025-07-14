//
//  MapHeaderSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class MapHeaderSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any MapHeaderSectionMapperContract).self,
                                            MapHeaderSectionMapper.self)
    }
}
