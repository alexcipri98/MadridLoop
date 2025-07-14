//
//  MadridRepository.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRepository: GetEventsCalendarRepositoryContract {

    public let getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
    public let landingEntriesEntityMapper: LandingEntriesEntityMapperContract
    required public init() {
        @Injected var getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
        @Injected var landingEntriesEntityMapper: LandingEntriesEntityMapperContract
        self.getEventsCalendarRemoteDataSource = getEventsCalendarRemoteDataSource
        self.landingEntriesEntityMapper = landingEntriesEntityMapper
    }

    public func getEventsCalendar() async throws -> [LandingEntryModel] {
        let entity = try await getEventsCalendarRemoteDataSource.getEventsCalendar()
        return try landingEntriesEntityMapper.map(entity)
    }
}
