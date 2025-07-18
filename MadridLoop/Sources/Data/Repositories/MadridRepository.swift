//
//  MadridRepository.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class MadridRepository: GetEventsCalendarRepositoryContract,
                             GetDogsInformationRepositoryContract,
                             GetMarketsInformationRepositoryContract {

    public let getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
    public let getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
    public let getMarketsInformationRemoteDataSource: GetMarketsRemoteDataSourceContract
    public let landingEntriesEntityMapper: LandingEntriesEntityMapperContract
    public let dogsTrashEntityMapper: DogsTrashEntityMapperContract
    public let dogsFontsEntityMapper: DogsFontsEntityMapperContract
    public let normalFontsEntityMapper: NormalFontsEntityMapperContract
    public let getMarketsEntityMapper: GetMarketsEntityMapperContract

    required public init() {
        @Injected var getEventsCalendarRemoteDataSource: GetEventsCalendarRemoteDataSourceContract
        @Injected var landingEntriesEntityMapper: LandingEntriesEntityMapperContract
        @Injected var getDogsInformationRemoteDataSource: GetDogsInformationRemoteDataSourceContract
        @Injected var getMarketsInformationRemoteDataSource: GetMarketsRemoteDataSourceContract
        @Injected var dogsTrashEntityMapper: DogsTrashEntityMapperContract
        @Injected var dogsFontsEntityMapper: DogsFontsEntityMapperContract
        @Injected var normalFontsEntityMapper: NormalFontsEntityMapperContract
        @Injected var getMarketsEntityMapper: GetMarketsEntityMapperContract
        self.getEventsCalendarRemoteDataSource = getEventsCalendarRemoteDataSource
        self.landingEntriesEntityMapper = landingEntriesEntityMapper
        self.getDogsInformationRemoteDataSource = getDogsInformationRemoteDataSource
        self.dogsTrashEntityMapper = dogsTrashEntityMapper
        self.dogsFontsEntityMapper = dogsFontsEntityMapper
        self.normalFontsEntityMapper = normalFontsEntityMapper
        self.getMarketsInformationRemoteDataSource = getMarketsInformationRemoteDataSource
        self.getMarketsEntityMapper = getMarketsEntityMapper
    }

    open func getEventsCalendar() async throws -> [EventEntryModel] {
        let entity = try await getEventsCalendarRemoteDataSource.getEventsCalendar()
        return try landingEntriesEntityMapper.map(entity)
    }

    open func getDogsInformation(distrit: String) async throws -> [DogsInformationModel] {
        async let trashEntity = getDogsInformationRemoteDataSource.getDogsTrashInformation(distrit: distrit)
        async let dogsFontsEntity = getDogsInformationRemoteDataSource.getDogsFonts(district: distrit)
        async let normalFontsEntity = getDogsInformationRemoteDataSource.getNormalFonts(district: distrit)
        let (trash, fonts, normalFonts) = try await (trashEntity, dogsFontsEntity, normalFontsEntity)
        let trashModel = try dogsTrashEntityMapper.map(trash)
        let fontsModel = try dogsFontsEntityMapper.map(fonts)
        let normalFontsModel = try normalFontsEntityMapper.map(normalFonts)
        return trashModel + fontsModel + normalFontsModel
    }

    open func getMarketsInformation() async throws -> [MarketInformationModel] {
        let entity = try await getMarketsInformationRemoteDataSource.getMarkets()
        return try getMarketsEntityMapper.map(entity)
    }
}
