//
//  VersionEntity.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 11/8/25.
//

import Foundation

open class VersionEntity: Codable {
    public let minimumVersion: String?
    public let url: String?
    public let updateRequired: Bool?
    
    public init(minimumVersion: String?,
                url: String?,
                updateRequired: Bool?) {
        self.minimumVersion = minimumVersion
        self.url = url
        self.updateRequired = updateRequired
    }
}
