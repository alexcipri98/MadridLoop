//
//  MapPresentationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Foundation
import MapKit

open class MapPresentationModel {
    public let userLocation: CLLocationCoordinate2D?
    public let identifier: String
    public let places: [Location]
    public let iconName: String?
    public let action: ((String) -> Void)?

    public init(userLocation: CLLocationCoordinate2D?,
                identifier: String,
                places: [Location],
                iconName: String? = nil,
                action: ((String) -> Void)? = nil) {
        self.userLocation = userLocation
        self.identifier = identifier
        self.places = places
        self.iconName = iconName
        self.action = action
    }
}
