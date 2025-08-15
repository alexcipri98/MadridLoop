//
//  VersionUpdateHeaderSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public struct VersionUpdateContentSectionRenderModel {
    public let iconName: String?
    public let text: String?
    public let url: URL?
    
    public init(iconName: String?,
                text: String?,
                url: URL?) {
        self.iconName = iconName
        self.text = text
        self.url = url
    }

    public static func empty() -> VersionUpdateContentSectionRenderModel {
        .init(iconName: nil, text: nil, url: nil)
    }
}
