//
//  ListMerchantsHeaderSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListMerchantsHeaderSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any ListMerchantsHeaderSectionMapperContract).self,
                                            ListMerchantsHeaderSectionMapper.self)
    }
}
