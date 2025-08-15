//
//  MadridRemoteDataSource.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRemoteDataSource: GetEventsCalendarRemoteDataSourceContract,
                                   GetDogsInformationRemoteDataSourceContract,
                                   GetMarketsRemoteDataSourceContract,
                                   GetVersionRemoteDataSourceContract {

    public let madridAPI: MadridAPIContract
    public let landingEntriesMapper: LandingEntriesEntityMapperContract
    public let dogsTrashMapper: DogsTrashEntityMapperContract
    public let dogsZonesMapper: DogsZonesEntityMapperContract
    public let normalFontsMapper: NormalFontsEntityMapperContract
    public let getMarketsMapper: GetMarketsEntityMapperContract
    public let versionMapper: VersionEntityMapperContract

    public required init() {
        @Injected var madridAPI: MadridAPIContract
        @Injected var landingEntriesMapper: LandingEntriesEntityMapperContract
        @Injected var dogsTrashMapper: DogsTrashEntityMapperContract
        @Injected var dogsZonesMapper: DogsZonesEntityMapperContract
        @Injected var normalFontsMapper: NormalFontsEntityMapperContract
        @Injected var getMarketsMapper: GetMarketsEntityMapperContract
        @Injected var versionMapper: VersionEntityMapperContract
        self.madridAPI = madridAPI
        self.landingEntriesMapper = landingEntriesMapper
        self.dogsTrashMapper = dogsTrashMapper
        self.dogsZonesMapper = dogsZonesMapper
        self.normalFontsMapper = normalFontsMapper
        self.getMarketsMapper = getMarketsMapper
        self.versionMapper = versionMapper
    }

    open func getEventsCalendar() async throws -> LandingEntriesEntity {
        let data = try await madridAPI.getEventsCalendar().execute()
        return try landingEntriesMapper.map(data)
    }

    open func getDogsTrashInformation(distrit: String) async throws -> DogTrashEntity {
        let data = try await madridAPI.getDogsInformation(distrit: distrit).execute()
        return try dogsTrashMapper.map(data)
    }

    open func getDogsZones(district: String) async throws -> DogsZonesEntity {
        let data = try await madridAPI.getDogsZones(distrit: district).execute()
        return try dogsZonesMapper.map(data)
    }

    open func getNormalFonts(district: String) async throws -> NormalFontsEntity {
        let data = try await madridAPI.getNormalFonts(distrit: district).execute()
        return try normalFontsMapper.map(data)
    }

    open func getMarkets() async throws -> MarketsEntity {
        let data = try await madridAPI.getMarkets().execute()
        return try getMarketsMapper.map(data)
    }

    open func getVersion(version: String) async throws -> VersionEntity {
        let data = try await madridAPI.getVersion(version: version).execute()
        return try versionMapper.map(data)
    }
}
