//
//  LocationPermissionModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LocationPermissionModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(LocationPermissionViewModelContract.self,
                                            LocationPermissionViewModel.self)
        DependencyContainer.shared.register(LocationPermissionNavigationBuilderContract.self,
                                            LocationPermissionNavigationBuilder.self)
    }
}

