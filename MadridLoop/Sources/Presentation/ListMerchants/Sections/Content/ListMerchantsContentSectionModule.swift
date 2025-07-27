//
//  ListMerchantsContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListMerchantsContentSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any ListMerchantsContentSectionMapperContract).self,
                                            ListMerchantsContentSectionMapper.self)
    }
}
