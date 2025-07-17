//
//  MadridRemoteDataSource.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRemoteDataSource: GetEventsCalendarRemoteDataSourceContract,
                                   GetDogsInformationRemoteDataSourceContract {

    public let madridAPI: MadridAPIContract
    public let landingEntriesMapper: LandingEntriesEntityMapperContract
    public let dogsInformationMapper: DogsInformationEntityMapperContract

    public required init() {
        @Injected var madridAPI: MadridAPIContract
        @Injected var landingEntriesMapper: LandingEntriesEntityMapperContract
        @Injected var dogsInformationMapper: DogsInformationEntityMapperContract
        self.madridAPI = madridAPI
        self.landingEntriesMapper = landingEntriesMapper
        self.dogsInformationMapper = dogsInformationMapper
    }

    open func getEventsCalendar() async throws -> LandingEntriesEntity {
        let data = try await madridAPI.getEventsCalendar().execute()
        return try landingEntriesMapper.map(data)
    }

    open func getDogsTrashInformation(distrit: String) async throws -> DogTrashEntity {
        let data = try await madridAPI.getDogsInformation(distrit: distrit).execute()
        return try dogsInformationMapper.map(data)
    }
}
