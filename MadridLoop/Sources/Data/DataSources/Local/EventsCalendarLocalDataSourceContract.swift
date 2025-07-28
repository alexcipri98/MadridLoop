//
//  EventsCalendarLocalDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 27/7/25.
//

import Foundation
import DependencyInjector

public protocol EventsCalendarLocalDataSourceContract: Instanciable {
    func getCachedEvents() async throws -> [EventEntryModel]?
    func saveEvents(_ events: [EventEntryModel]) async throws
    func cleanEventsCache() async
}
