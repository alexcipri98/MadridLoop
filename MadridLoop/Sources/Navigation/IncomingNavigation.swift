//
//  IncomingNavigation.swift
//  loveAnimal
//
//  Created by Alex Ciprian lopez on 22/1/25.
//

import Navigation

public enum IncomingNavigation: NavigationInfo {
    case entryPoint

    public var presentationType: PresentationType {
        switch self {
        case .entryPoint:
            return .goToRoot
        }
    }
}
