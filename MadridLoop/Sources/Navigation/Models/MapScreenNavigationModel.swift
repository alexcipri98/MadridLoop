//
//  MapNavigationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Foundation

open class MapScreenNavigationModel {
    public let identifier: String
    public let places: [Location]
    public let action: ((String) -> Void)?

    public init(identifier: String, places: [Location], action: ((String) -> Void)? = nil) {
        self.identifier = identifier
        self.places = places
        self.action = action
    }
}
