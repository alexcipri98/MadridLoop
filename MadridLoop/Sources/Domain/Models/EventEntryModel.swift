//
//  LandingEntryModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

open class EventEntryModel {
    let id: String
    let title: String
    let description: String
    let free: Int?
    let price: String?
    let dtStart: String
    let dtEnd: String?
    let location: LocationModel?
    let link: String?
    let address: AddressModel?

    public init(id: String,
                title: String,
                description: String,
                free: Int?,
                price: String?,
                dtStart: String,
                dtEnd: String?,
                location: LocationModel?,
                link: String?,
                address: AddressModel?) {
        self.id = id
        self.title = title
        self.description = description
        self.free = free
        self.price = price
        self.dtStart = dtStart
        self.dtEnd = dtEnd
        self.location = location
        self.link = link
        self.address = address
    }

    open class LocationModel {
        let latitude: Double
        let longitude: Double
        
        public init(latitude: Double,
                    longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    open class AddressModel {
        let district: String?
        let locality: String?
        let postalCode: String?
        let streetAddress: String?
        
        public init(district: String?,
                    locality: String?,
                    postalCode: String?,
                    streetAddress: String?) {
            self.district = district
            self.locality = locality
            self.postalCode = postalCode
            self.streetAddress = streetAddress
        }
    }
}
