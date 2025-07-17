//
//  MadridRepository.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRepository: GetEventsCalendarRepositoryContract,
                             GetDogsInformationRepositoryContract {

    public let getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
    public let getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
    public let landingEntriesEntityMapper: LandingEntriesEntityMapperContract
    public let dogsInformationEntityMapper: DogsInformationEntityMapperContract

    required public init() {
        @Injected var getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
        @Injected var landingEntriesEntityMapper: LandingEntriesEntityMapperContract
        @Injected var getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
        @Injected var dogsInformationEntityMapper: DogsInformationEntityMapperContract
        self.getEventsCalendarRemoteDataSource = getEventsCalendarRemoteDataSource
        self.landingEntriesEntityMapper = landingEntriesEntityMapper
        self.getDogsInformationRemoteDataSource = getDogsInformationRemoteDataSource
        self.dogsInformationEntityMapper = dogsInformationEntityMapper
    }

    open func getEventsCalendar() async throws -> [EventEntryModel] {
        let entity = try await getEventsCalendarRemoteDataSource.getEventsCalendar()
        return try landingEntriesEntityMapper.map(entity)
    }

    open func getDogsInformation(distrit: String) async throws -> [DogsInformationModel] {
        let entity = try await getDogsInformationRemoteDataSource.getDogsTrashInformation(distrit: distrit)
        return try dogsInformationEntityMapper.map(entity)
    }
}
