//
//  ListEventsContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListEventsContentSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any ListEventsContentSectionMapperContract).self,
                                            ListEventsContentSectionMapper.self)
    }
}
