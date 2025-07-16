//
//  LandingEntryEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation
import CoreLocation

open class LandingEntriesEntity: Codable {
    public let graph: [Event]?

    public enum CodingKeys: String, CodingKey {
        case graph = "@graph"
    }
}

// MARK: - Event
open class Event: Codable {
    public let id: String?
    public let title: String?
    public let description: String?
    public let free: Int?
    public let price: String?
    public let dtstart: String?
    public let dtend: String?
    public let time: String?
    public let excludedDays: String?
    public let uid: String?
    public let link: String?
    public let eventLocation: String?
    public let references: Reference?
    public let relation: Reference?
    public let address: Address?
    public let location: GeoLocation?
    public let organization: Organization?
    public let recurrence: RecurrenceRule?

    enum CodingKeys: String, CodingKey {
        case id, title, description, free, price, dtstart, dtend, time
        case excludedDays = "excluded-days"
        case uid, link
        case eventLocation = "event-location"
        case references, relation, address, location, organization, recurrence
    }
}

// MARK: - Reference (used for 'references' and 'relation')
open class Reference: Codable {
    public let id: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
    }
}

// MARK: - Address
open class Address: Codable {
    public let district: Reference?
    public let area: Area?
}

// MARK: - Area (includes locality and street info)
open class Area: Codable {
    public let id: String?
    public let locality: String?
    public let postalCode: String?
    public let streetAddress: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case locality
        case postalCode = "postal-code"
        case streetAddress = "street-address"
    }
}

// MARK: - GeoLocation
open class GeoLocation: Codable {
    public let latitude: Double?
    public let longitude: Double?
}

// MARK: - Organization
open class Organization: Codable {
    public let organizationName: String?
    public let accesibility: String?

    enum CodingKeys: String, CodingKey {
        case organizationName = "organization-name"
        case accesibility
    }
}

// MARK: - RecurrenceRule
open class RecurrenceRule: Codable {
    public let days: String?
    public let frequency: String?
    public let interval: Int?
}
