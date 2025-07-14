//
//  MadridRemoteDataSource.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRemoteDataSource: GetEventsCalendarRemoteDataSourceContract {
    let madridAPI: MadridAPIContract
    let mapper: LandingEntriesEntityMapperContract
    public required init() {
        @Injected var madridAPI: MadridAPIContract
        @Injected var mapper: LandingEntriesEntityMapperContract
        self.madridAPI = madridAPI
        self.mapper = mapper
    }

    public func getEventsCalendar() async throws -> LandingEntriesEntity {
        let data = try await madridAPI.getEventsCalendar().execute()
        return try mapper.map(data)
    }
}
