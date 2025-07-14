//
//  LandingModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class LandingModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(LandingViewModelContract.self, LandingViewModel.self)
        DependencyContainer.shared.register(LandingNavigationBuilderContract.self, LandingNavigationBuilder.self)
    }
}

