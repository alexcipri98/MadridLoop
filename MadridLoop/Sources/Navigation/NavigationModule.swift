//
//  NavigationModule.swift
//  loveAnimal
//
//  Created by Alex Ciprian lopez on 22/1/25.
//

import DependencyInjector
import Navigation

final class NavigationModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(ScreenNavigator.self, Navigator.self)
    }
}
