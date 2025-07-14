//
//  LandingNavigationBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Navigation
import DependencyInjector
import PresentationLayer

public protocol LandingNavigationBuilderContract: NavigationBuilder {
    func navigateToPetDetail(petId: String)
    func goBack()
}

open class LandingNavigationBuilder: LandingNavigationBuilderContract {
    public required init() {}

    public func navigateToPetDetail(petId: String) {}
    
    open func goBack() {
        self.goBack(animated: true, screen: nil, nil)
    }

    public func goBack(animated: Bool, screen: (any Navigation.NavigationInfo)?, _ completion: (() -> Void)?) {
        Router.shared.goBackTo(times: 1)
    }
}

