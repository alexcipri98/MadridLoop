//
//  Location.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import MapKit
import SwiftUI

open class Location: Identifiable {
    public let id: String
    public let iconName: String?
    public let iconColor: Color?
    public let startTime: Date?
    public let endTime: Date?
    let coordinate: CLLocationCoordinate2D
    
    public init(id: String,
                iconName: String? = nil,
                iconColor: Color? = nil,
                startTime: Date? = nil,
                endTime: Date? = nil,
                coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.iconName = iconName
        self.iconColor = iconColor
        self.startTime = startTime
        self.endTime = endTime
        self.coordinate = coordinate
    }

    static func fromEventToLocation(_ event: EventEntryModel) -> Location? {
        guard let lat = event.location?.latitude,
              let long = event.location?.longitude else {
            return nil
        }
        let coordinate = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long
        )
        let date = event.dtStart.parseStringToDate()
        let dateEnd = event.dtEnd?.parseStringToDate()
        return Location(id: event.id,
                        iconName: "mappin.circle.fill",
                        startTime: date,
                        endTime: dateEnd,
                        coordinate: coordinate)
    }

    static func fromDogToLocation(_ dog: DogsInformationModel) -> Location? {
        let coordinate = CLLocationCoordinate2D(
            latitude: dog.location.latitude,
            longitude: dog.location.longitude
        )
        switch dog.typeOfElement {
        case .dogFont:
            return Location(id: dog.id,
                            iconName: IconsNames.dogPark.rawValue,
                            coordinate: coordinate)
        case .font:
            return Location(id: dog.id,
                            iconName: IconsNames.normalFont.rawValue,
                            iconColor: .blue,
                            coordinate: coordinate)
        case .trash:
            return Location(id: dog.id,
                            iconName: IconsNames.trash.rawValue,
                            iconColor: .brown,
                            coordinate: coordinate)
        }
    }

    static func fromMarketsToLocation(_ market: MarketInformationModel) -> Location? {
        guard let latitude = market.latitude,
              let longitude = market.longitude,
              let id = market.id else {
            return nil
        }
        let coordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        return Location(id: id,
                        iconName: "cart.fill",
                        coordinate: coordinate)
    }
}
