//
//  Navigator.swift
//  loveAnimal
//
//  Created by Alex Ciprian lopez on 22/1/25.
//

import SwiftUI
import Navigation

public class Navigator: ScreenNavigator {
    public required init() {}

    public func destinationFor(navigationInfo: any NavigationInfo) throws -> (any View)? {
        guard let navigation = navigationInfo as? IncomingNavigation else {
            return nil
        }
        let destination = try handleDestinationFor(navigationInfo: navigation)
        return destination
    }

    private func handleDestinationFor(navigationInfo: IncomingNavigation) throws -> (any View)? {
        switch navigationInfo {
        case .entryPoint:
            return LandingBuilder().setIdentifier("").build()
        case .mapScreen(let navigationModel):
            return MapBuilder().setNavigationModel(navigationModel).build()
        case .informationMapModal(let navigationModel):
            return InformationMapModalBuilder().setNavigationModel(navigationModel).build()
        }
    }
}
