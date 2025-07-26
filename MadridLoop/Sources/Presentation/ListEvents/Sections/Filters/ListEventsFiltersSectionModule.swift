//
//  ListEventsContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListEventsFiltersSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any ListEventsFiltersSectionMapperContract).self,
                                            ListEventsFiltersSectionMapper.self)
    }
}
