//
//  MapNavigationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Foundation

open class MapNavigationModel {
    let identifier: String
    let places: [Location]
    let iconName: String?
    let action: ((String) -> Void)?

    public init(identifier: String, places: [Location], iconName: String?, action: ((String) -> Void)?) {
        self.identifier = identifier
        self.places = places
        self.iconName = iconName
        self.action = action
    }
}
