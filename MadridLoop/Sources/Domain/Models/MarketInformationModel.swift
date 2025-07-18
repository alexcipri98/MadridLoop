//
//  MarketInformationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import Foundation

open class MarketInformationModel {
    public let id: String?
    public let title: String?
    public let services: String?
    public let schedule: String?
    public let streetAddress: String?
    public let postalCode: String?
    public let latitude: Double?
    public let longitude: Double?
    public let relation: String?

    public init(id: String?,
                title: String?,
                services: String?,
                schedule: String?,
                streetAddress: String?,
                postalCode: String?,
                latitude: Double?,
                longitude: Double?,
                relation: String?) {
        self.id = id
        self.title = title
        self.services = services
        self.schedule = schedule
        self.streetAddress = streetAddress
        self.postalCode = postalCode
        self.latitude = latitude
        self.longitude = longitude
        self.relation = relation
    }
}
