//
//  ListMerchantsModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListMerchantsModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(ListMerchantsViewModelContract.self, ListMerchantsViewModel.self)
        DependencyContainer.shared.register(ListMerchantsNavigationBuilderContract.self, ListMerchantsNavigationBuilder.self)
    }
}

