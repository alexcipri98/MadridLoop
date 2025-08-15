//
//  VersionUpdateNavigationBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Navigation
import DependencyInjector
import PresentationLayer
import UIKit

public protocol VersionUpdateNavigationBuilderContract: NavigationBuilder {
    func goToSettings()
    func goBack()
}

open class VersionUpdateNavigationBuilder: VersionUpdateNavigationBuilderContract {
    public required init() {}
    
    open func goBack() {
        self.goBack(animated: true, screen: nil, nil)
    }

    open func goToSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }

    open func goBack(animated: Bool, screen: (any Navigation.NavigationInfo)?, _ completion: (() -> Void)?) {
        Router.shared.goBackTo(times: 1)
    }
}

