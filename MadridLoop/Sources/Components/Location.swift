//
//  Location.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import MapKit

open class Location: Identifiable {
    public let id: String
    let coordinate: CLLocationCoordinate2D
    
    init(id: String,
         coordinate: CLLocationCoordinate2D) {
        self.id = id
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
        return Location(id: event.id, coordinate: coordinate)
    }
}
