//
//  IncomingNavigation.swift
//  loveAnimal
//
//  Created by Alex Ciprian lopez on 22/1/25.
//

import Navigation

public enum IncomingNavigation: NavigationInfo {
    case entryPoint(identifier: String)
    case mapScreen(navigationModel: MapScreenNavigationModel)
    case informationMapModal(navigationModel: InformationMapModalNavigationModel)
    case listEvents
    case listMerchants
    case versionUpdate(navigationModel: VersionModel)
    case locationPermission

    public var presentationType: PresentationType {
        switch self {
        case .entryPoint:
            return .goToRoot
        case .mapScreen, .listEvents, .listMerchants, .versionUpdate, .locationPermission:
            return .push
        case .informationMapModal:
            return .modal
        }
    }
}
