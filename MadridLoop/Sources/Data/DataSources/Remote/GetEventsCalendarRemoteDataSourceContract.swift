//
//  GetEventsCalendarRemoteDataSourceContract.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

public protocol GetEventsCalendarRemoteDataSourceContract: Instanciable {
    func getEventsCalendar() async throws -> LandingEntriesEntity
}
