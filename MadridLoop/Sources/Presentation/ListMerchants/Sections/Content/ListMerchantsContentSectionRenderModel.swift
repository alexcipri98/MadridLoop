//
//  ListMerchantsContentSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum ListMerchantsContentSectionRenderModel {
    case hidden
    case show([ListMerchantsMarketsDataRenderModel])

    public struct ListMerchantsMarketsDataRenderModel: Identifiable {
        public let id: String
        public let title: String
        public let description: String
        public let location: String?
        public let link: String?
        public let latitude: Double?
        public let longitude: Double?

        public init(id: String,
                    title: String,
                    description: String,
                    location: String?,
                    link: String?,
                    latitude: Double?,
                    longitude: Double?) {
            self.id = id
            self.title = title
            self.description = description
            self.location = location
            self.link = link
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
