//
//  ListMerchantsNavigationBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Navigation
import DependencyInjector
import PresentationLayer

public protocol ListMerchantsNavigationBuilderContract: NavigationBuilder {
    func navigateToMapScreen(mapScreenNavigationModel: MapScreenNavigationModel)
    func navigateToModal(_ informationMapModalNavigationModel: InformationMapModalNavigationModel)
    func goBack()
}

open class ListMerchantsNavigationBuilder: ListMerchantsNavigationBuilderContract {
    public required init() {}

    public func navigateToPetDetail(petId: String) {}
    
    open func goBack() {
        self.goBack(animated: true, screen: nil, nil)
    }

    open func navigateToMapScreen(mapScreenNavigationModel: MapScreenNavigationModel) {
        let navigationInfo = IncomingNavigation.mapScreen(navigationModel: mapScreenNavigationModel)
        Router.shared.navigateTo(navigationInfo)
    }

    open func navigateToModal(_ informationMapModalNavigationModel: InformationMapModalNavigationModel) {
        let navigationInfo = IncomingNavigation.informationMapModal(navigationModel: informationMapModalNavigationModel)
        Router.shared.navigateTo(navigationInfo)
    }

    open func goBack(animated: Bool, screen: (any Navigation.NavigationInfo)?, _ completion: (() -> Void)?) {
        Router.shared.goBackTo(times: 1)
    }
}

