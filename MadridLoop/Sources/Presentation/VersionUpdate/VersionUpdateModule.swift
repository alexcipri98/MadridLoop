//
//  VersionUpdateModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class VersionUpdateModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(VersionUpdateViewModelContract.self,
                                            VersionUpdateViewModel.self)
        DependencyContainer.shared.register(VersionUpdateNavigationBuilderContract.self,
                                            VersionUpdateNavigationBuilder.self)
    }
}

