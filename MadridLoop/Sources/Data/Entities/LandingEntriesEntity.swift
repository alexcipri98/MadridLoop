//
//  LandingEntryEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation
import CoreLocation

public class LandingEntriesEntity: Codable {
    let graph: [Event]?

    enum CodingKeys: String, CodingKey {
        case graph = "@graph"
    }
}

// MARK: - Event
public class Event: Codable {
    let id: String?
    let title: String?
    let description: String?
    let free: Int?
    let price: String?
    let dtstart: String?
    let dtend: String?
    let time: String?
    let excludedDays: String?
    let uid: String?
    let link: String?
    let eventLocation: String?
    let references: Reference?
    let relation: Reference?
    let address: Address?
    let location: GeoLocation?
    let organization: Organization?
    let recurrence: RecurrenceRule?

    enum CodingKeys: String, CodingKey {
        case id, title, description, free, price, dtstart, dtend, time
        case excludedDays = "excluded-days"
        case uid, link
        case eventLocation = "event-location"
        case references, relation, address, location, organization, recurrence
    }
}

// MARK: - Reference (used for 'references' and 'relation')
public class Reference: Codable {
    let id: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
    }
}

// MARK: - Address
public class Address: Codable {
    let district: Reference?
    let area: Area?
}

// MARK: - Area (includes locality and street info)
public class Area: Codable {
    let id: String?
    let locality: String?
    let postalCode: String?
    let streetAddress: String?

    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case locality
        case postalCode = "postal-code"
        case streetAddress = "street-address"
    }
}

// MARK: - GeoLocation
public class GeoLocation: Codable {
    let latitude: Double?
    let longitude: Double?
}

// MARK: - Organization
public class Organization: Codable {
    let organizationName: String?
    let accesibility: String?

    enum CodingKeys: String, CodingKey {
        case organizationName = "organization-name"
        case accesibility
    }
}

// MARK: - RecurrenceRule
public class RecurrenceRule: Codable {
    let days: String?
    let frequency: String?
    let interval: Int?
}
