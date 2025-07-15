//
//  InformationMapModalModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class InformationMapModalModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(InformationMapModalViewModelContract.self,
                                            InformationMapModalViewModel.self)
        DependencyContainer.shared.register(InformationMapModalNavigationBuilderContract.self,
                                            InformationMapModalNavigationBuilder.self)
    }
}

