//
//  MadridRepository.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRepository: GetEventsCalendarRepositoryContract,
                             GetDogsInformationRepositoryContract,
                             GetMarketsInformationRepositoryContract,
                             GetVersionRepositoryContract {

    // Remotes
    public let getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
    public let getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
    public let getMarketsInformationRemoteDataSource: GetMarketsRemoteDataSourceContract
    public let versionRemoteDataSource: GetVersionRemoteDataSourceContract

    // Locals
    public let eventsCalendarLocalDataSource: EventsCalendarLocalDataSourceContract
    public let dogsInformationLocalDataSource: DogsInformationLocalDataSourceContract
    public let marketsInformationLocalDataSource: MarketsLocalDataSourceContract

    // Mappers
    public let landingEntriesEntityMapper: LandingEntriesEntityMapperContract
    public let dogsTrashEntityMapper: DogsTrashEntityMapperContract
    public let dogsFontsEntityMapper: DogsFontsEntityMapperContract
    public let normalFontsEntityMapper: NormalFontsEntityMapperContract
    public let getMarketsEntityMapper: GetMarketsEntityMapperContract
    public let versionEntityMapper: VersionEntityMapperContract

    private var inMemoryEvents: [EventEntryModel]? = nil

    required public init() {
        // Remotes
        @Injected var getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
        @Injected var landingEntriesEntityMapper: LandingEntriesEntityMapperContract
        @Injected var getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
        @Injected var getMarketsInformationRemoteDataSource: GetMarketsRemoteDataSourceContract
        @Injected var versionRemoteDataSource: GetVersionRemoteDataSourceContract
    
        // Locals
        @Injected var eventsCalendarLocalDataSource: EventsCalendarLocalDataSourceContract
        @Injected var dogsInformationLocalDataSource: DogsInformationLocalDataSourceContract
        @Injected var marketsInformationLocalDataSource: MarketsLocalDataSourceContract

        // Mappers
        @Injected var dogsTrashEntityMapper: DogsTrashEntityMapperContract
        @Injected var dogsFontsEntityMapper: DogsFontsEntityMapperContract
        @Injected var normalFontsEntityMapper: NormalFontsEntityMapperContract
        @Injected var getMarketsEntityMapper: GetMarketsEntityMapperContract
        @Injected var versionEntityMapper: VersionEntityMapperContract

        // Remotes
        self.getEventsCalendarRemoteDataSource = getEventsCalendarRemoteDataSource
        self.landingEntriesEntityMapper = landingEntriesEntityMapper
        self.getDogsInformationRemoteDataSource = getDogsInformationRemoteDataSource
        self.versionRemoteDataSource = versionRemoteDataSource

        // Locals
        self.eventsCalendarLocalDataSource = eventsCalendarLocalDataSource
        self.dogsInformationLocalDataSource = dogsInformationLocalDataSource
        self.marketsInformationLocalDataSource = marketsInformationLocalDataSource

        // Mappers
        self.dogsTrashEntityMapper = dogsTrashEntityMapper
        self.dogsFontsEntityMapper = dogsFontsEntityMapper
        self.normalFontsEntityMapper = normalFontsEntityMapper
        self.getMarketsInformationRemoteDataSource = getMarketsInformationRemoteDataSource
        self.getMarketsEntityMapper = getMarketsEntityMapper
        self.versionEntityMapper = versionEntityMapper
    }

    open func getEventsCalendar() async throws -> [EventEntryModel] {
        if let memory = inMemoryEvents {
            return memory
        }

        if let cached = try await eventsCalendarLocalDataSource.getCachedEvents(), !cached.isEmpty {
            inMemoryEvents = cached
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let entity = try await self.getEventsCalendarRemoteDataSource.getEventsCalendar()
                    let updated = try self.landingEntriesEntityMapper.map(entity)
                    try await self.eventsCalendarLocalDataSource.saveEvents(updated)
                    self.inMemoryEvents = updated
                } catch {
                    print("Background update failed: \(error)")
                }
            }
            return cached
        }

        let entity = try await getEventsCalendarRemoteDataSource.getEventsCalendar()
        let events = try landingEntriesEntityMapper.map(entity)
        try await eventsCalendarLocalDataSource.saveEvents(events)
        inMemoryEvents = events
        return events
    }

    open func getDogsInformation(distrit: String) async throws -> [DogsInformationModel] {
        let cached = try await dogsInformationLocalDataSource.getDogsInformation(distrit: distrit)
        if !cached.isEmpty {
            return cached
        }

        async let trashEntity = getDogsInformationRemoteDataSource.getDogsTrashInformation(distrit: distrit)
        async let dogsFontsEntity = getDogsInformationRemoteDataSource.getDogsFonts(district: distrit)
        async let normalFontsEntity = getDogsInformationRemoteDataSource.getNormalFonts(district: distrit)

        let (trash, fonts, normalFonts) = try await (trashEntity, dogsFontsEntity, normalFontsEntity)

        let trashModel = try dogsTrashEntityMapper.map(trash)
        let fontsModel = try dogsFontsEntityMapper.map(fonts)
        let normalFontsModel = try normalFontsEntityMapper.map(normalFonts)

        let result = trashModel + fontsModel + normalFontsModel
        dogsInformationLocalDataSource.addDogsInformation(result)
        return result
    }

    open func getMarketsInformation() async throws -> [MarketInformationModel] {
        if let cached = try await marketsInformationLocalDataSource.getCachedMarkets(), !cached.isEmpty {
            Task { [weak self] in
                guard let self = self else { return }
                do {
                    let entity = try await self.getMarketsInformationRemoteDataSource.getMarkets()
                    let updated = try self.getMarketsEntityMapper.map(entity)
                    try await self.marketsInformationLocalDataSource.saveMarkets(updated)
                } catch {
                    print("Background update failed: \(error)")
                }
            }
            return cached
        }

        let entity = try await getMarketsInformationRemoteDataSource.getMarkets()
        let markets = try getMarketsEntityMapper.map(entity)
        try await marketsInformationLocalDataSource.saveMarkets(markets)
        return markets
    }

    open func getVersion(version: String) async throws -> VersionModel {
        let result = try await versionRemoteDataSource.getVersion(version: version)
        return try versionEntityMapper.map(result)
    }
}
