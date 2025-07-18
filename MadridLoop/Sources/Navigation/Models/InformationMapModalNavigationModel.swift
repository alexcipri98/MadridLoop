//
//  InformationMapModalScreenNavigationModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import Foundation

open class InformationMapModalNavigationModel {
    public let title: String?
    public let description: String?
    public let location: Location?
    public let link: String?
    public let startTime: String?
    public let schedule: String?

    public init(title: String?,
                description: String?,
                location: Location?,
                link: String? = nil,
                startTime: String? = nil,
                schedule: String? = nil) {
        self.title = title
        self.description = description
        self.location = location
        self.link = link
        self.startTime = startTime
        self.schedule = schedule
    }
}
