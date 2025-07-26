//
//  LandingMarketsSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum LandingMarketsSectionRenderModel {
    case hidden
    case show(_ data: [LandingMarketsSectionData])

    public struct LandingMarketsSectionData {
        public let title: String
        public let description: String
        public let date: String
        public let icon: String
        public let link: String?

        public init(title: String, description: String, date: String, icon: String, link: String?) {
            self.title = title
            self.description = description
            self.date = date
            self.icon = icon
            self.link = link
        }
    }
}
