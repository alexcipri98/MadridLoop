//
//  GenericErrorSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public enum GenericErrorSectionRenderModel {
    case hidden
    case show(_ data: GenericErrorSectionData)

    public struct GenericErrorSectionData {
        public let title: String
        public let description: String
        public let icon: String
        public let buttonText: String

        public init(title: String,
                    description: String,
                    icon: String,
                    buttonText: String) {
            self.title = title
            self.description = description
            self.icon = icon
            self.buttonText = buttonText
        }
    }
}
