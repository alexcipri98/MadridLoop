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

    public var presentationType: PresentationType {
        switch self {
        case .entryPoint:
            return .goToRoot
        case .mapScreen, .listEvents:
            return .push
        case .informationMapModal:
            return .modal
        }
    }
}
