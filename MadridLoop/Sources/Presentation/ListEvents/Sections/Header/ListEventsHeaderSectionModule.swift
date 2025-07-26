//
//  ListEventsHeaderSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListEventsHeaderSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any ListEventsHeaderSectionMapperContract).self,
                                            ListEventsHeaderSectionMapper.self)
    }
}
