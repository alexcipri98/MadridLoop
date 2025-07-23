//
//  Location.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import MapKit

open class Location: Identifiable {
    public let id: String
    public let iconName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(id: String,
         iconName: String? = nil,
         coordinate: CLLocationCoordinate2D) {
        self.id = id
        self.iconName = iconName
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
        return Location(id: event.id,
                        iconName: "mappin.circle.fill", coordinate: coordinate)
    }

    static func fromDogToLocation(_ dog: DogsInformationModel) -> Location? {
        let coordinate = CLLocationCoordinate2D(
            latitude: dog.location.latitude,
            longitude: dog.location.longitude
        )
        switch dog.typeOfElement {
        case .dogFont:
            return Location(id: dog.id, iconName: IconsNames.dogFont.rawValue, coordinate: coordinate)
        case .font:
            return Location(id: dog.id, iconName: IconsNames.normalFont.rawValue, coordinate: coordinate)
        case .park:
            return Location(id: dog.id, iconName: IconsNames.park.rawValue, coordinate: coordinate)
        case .trash:
            return Location(id: dog.id, iconName: IconsNames.trash.rawValue, coordinate: coordinate)
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
        return Location(id: id, iconName: "cart.fill", coordinate: coordinate)
    }
}
