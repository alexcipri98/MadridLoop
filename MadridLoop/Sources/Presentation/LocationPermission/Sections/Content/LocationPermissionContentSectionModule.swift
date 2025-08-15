//
//  LocationPermissionContentSectionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LocationPermissionContentSectionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register((any LocationPermissionContentSectionMapperContract).self,
                                            LocationPermissionContentSectionMapper.self)
    }
}
