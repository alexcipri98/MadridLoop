//
//  LandingDogSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum LandingDogSectionRenderModel {
    case hidden
    case show(_ data: LandingDogSectionData)

    public struct LandingDogSectionData {
        public let title: String
        public let description: String
        public let icon: String

        public init(title: String, description: String, icon: String) {
            self.title = title
            self.description = description
            self.icon = icon
        }
    }
}
