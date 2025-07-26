//
//  MadridRemoteDataSource.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRemoteDataSource: GetEventsCalendarRemoteDataSourceContract,
                                   GetDogsInformationRemoteDataSourceContract,
                                   GetMarketsRemoteDataSourceContract {

    public let madridAPI: MadridAPIContract
    public let landingEntriesMapper: LandingEntriesEntityMapperContract
    public let dogsTrashMapper: DogsTrashEntityMapperContract
    public let dogsFontsMapper: DogsFontsEntityMapperContract
    public let normalFontsMapper: NormalFontsEntityMapperContract
    public let getMarketsMapper: GetMarketsEntityMapperContract

    public required init() {
        @Injected var madridAPI: MadridAPIContract
        @Injected var landingEntriesMapper: LandingEntriesEntityMapperContract
        @Injected var dogsTrashMapper: DogsTrashEntityMapperContract
        @Injected var dogsFontsMapper: DogsFontsEntityMapperContract
        @Injected var normalFontsMapper: NormalFontsEntityMapperContract
        @Injected var getMarketsMapper: GetMarketsEntityMapperContract
        self.madridAPI = madridAPI
        self.landingEntriesMapper = landingEntriesMapper
        self.dogsTrashMapper = dogsTrashMapper
        self.dogsFontsMapper = dogsFontsMapper
        self.normalFontsMapper = normalFontsMapper
        self.getMarketsMapper = getMarketsMapper
    }

    open func getEventsCalendar() async throws -> LandingEntriesEntity {
        let data = try await madridAPI.getEventsCalendar().execute()
        return try landingEntriesMapper.map(data)
    }

    open func getDogsTrashInformation(distrit: String) async throws -> DogTrashEntity {
        let data = try await madridAPI.getDogsInformation(distrit: distrit).execute()
        return try dogsTrashMapper.map(data)
    }

    open func getDogsFonts(district: String) async throws -> DogsFontsEntity {
        let data = try await madridAPI.getDogsFonts(distrit: district).execute()
        return try dogsFontsMapper.map(data)
    }

    open func getNormalFonts(district: String) async throws -> NormalFontsEntity {
        let data = try await madridAPI.getNormalFonts(distrit: district).execute()
        return try normalFontsMapper.map(data)
    }

    open func getMarkets() async throws -> MarketsEntity {
        let data = try await madridAPI.getMarkets().execute()
        return try getMarketsMapper.map(data)
    }
}
