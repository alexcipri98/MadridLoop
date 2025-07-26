//
//  LandingEventSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum LandingEventSectionRenderModel {
    case hidden
    case show([LandingEventDataRenderModel])

    public struct LandingEventDataRenderModel: Identifiable {
        public let id: String
        public let title: String
        public let description: String
        public let dateStart: String
        public let dateEnd: String?
        public let location: String?
        public let isItFree: Bool
        public let link: String?
        public let latitude: Double?
        public let longitude: Double?

        public init(id: String,
                    title: String,
                    description: String,
                    dateStart: String,
                    dateEnd: String?,
                    isItFree: Bool,
                    location: String?,
                    link: String?,
                    latitude: Double?,
                    longitude: Double?) {
            self.id = id
            self.title = title
            self.description = description
            self.dateStart = dateStart
            self.dateEnd = dateEnd
            self.isItFree = isItFree
            self.location = location
            self.link = link
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}
