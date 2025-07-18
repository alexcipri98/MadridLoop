//
//  MarketsEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 17/7/25.
//

import Foundation

open class MarketsEntity: Decodable {
    public let graph: [MarketEntity]?

    private enum CodingKeys: String, CodingKey {
        case graph = "@graph"
    }
}

open class MarketEntity: Decodable {
    public let id: String?
    public let title: String?
    public let relation: String?
    public let address: MarketAddressEntity?
    public let location: MarketLocationEntity?
    public let organization: MarketOrganizationEntity?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case relation
        case address
        case location
        case organization
    }
}

open class MarketAddressEntity: Decodable {
    public let locality: String?
    public let postalCode: String?
    public let streetAddress: String?

    private enum CodingKeys: String, CodingKey {
        case locality
        case postalCode = "postal-code"
        case streetAddress = "street-address"
    }
}

open class MarketLocationEntity: Decodable {
    public let latitude: Double?
    public let longitude: Double?
}

open class MarketOrganizationEntity: Decodable {
    public let organizationDesc: String?
    public let accesibility: String?
    public let schedule: String?
    public let services: String?
    public let organizationName: String?

    private enum CodingKeys: String, CodingKey {
        case organizationDesc = "organization-desc"
        case accesibility
        case schedule
        case services
        case organizationName = "organization-name"
    }
}
