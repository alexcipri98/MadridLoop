//
//  LocationPermissionHeaderSectionRenderModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Foundation

public struct LocationPermissionContentSectionRenderModel {
    public let iconName: String?
    public let text: String?
    
    public init(iconName: String?,
                text: String?) {
        self.iconName = iconName
        self.text = text
    }

    public static func empty() -> LocationPermissionContentSectionRenderModel {
        .init(iconName: nil, text: nil)
    }
}
