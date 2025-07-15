//
//  InformationMapModalContentSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum InformationMapModalContentSectionRenderModel {
    case hidden
    case show(_ data: InformationMapModalContentSectionData)

    public struct InformationMapModalContentSectionData {
        public let title: String
        public let description: String
        public let location: Location
        public let link: String?
        public let startTime: String?

        public init(title: String,
                    description: String,
                    location: Location,
                    link: String? = nil,
                    startTime: String? = nil) {
            self.title = title
            self.description = description
            self.location = location
            self.link = link
            self.startTime = startTime
        }
    }
}
