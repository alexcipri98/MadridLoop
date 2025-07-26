//
//  ListEventsModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class ListEventsModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(ListEventsViewModelContract.self, ListEventsViewModel.self)
        DependencyContainer.shared.register(ListEventsNavigationBuilderContract.self, ListEventsNavigationBuilder.self)
    }
}

