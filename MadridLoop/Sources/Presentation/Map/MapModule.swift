//
//  MapModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class MapModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(MapViewModelContract.self,
                                            MapViewModel.self)
        DependencyContainer.shared.register(MapNavigationBuilderContract.self,
                                            MapNavigationBuilder.self)
    }
}

