//
//  DataModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class DataModule: ModuleContract {
    static func inject() {
        // API
        DependencyContainer.shared.register(MadridAPIContract.self,
                                            MadridAPI.self)

        // DataSources
        DependencyContainer.shared.register(GetEventsCalendarRemoteDataSourceContract.self,
                                            MadridRemoteDataSource.self)
        DependencyContainer.shared.register(GetDogsInformationRemoteDataSourceContract.self,
                                            MadridRemoteDataSource.self)
        DependencyContainer.shared.register(GetMarketsRemoteDataSourceContract.self,
                                            MadridRemoteDataSource.self)

        // Mappers
        DependencyContainer.shared.register(LandingEntriesEntityMapperContract.self,
                                            LandingEntriesEntityMapper.self)
        DependencyContainer.shared.register(DogsTrashEntityMapperContract.self,
                                            DogsTrashEntityMapper.self)
        DependencyContainer.shared.register(DogsFontsEntityMapperContract.self,
                                            DogsFontsEntityMapper.self)
        DependencyContainer.shared.register(NormalFontsEntityMapperContract.self,
                                            NormalFontsEntityMapper.self)
        DependencyContainer.shared.register(GetMarketsEntityMapperContract.self,
                                            GetMarketsFontsEntityMapper.self)

        // Repositories
        DependencyContainer.shared.register(GetEventsCalendarRepositoryContract.self,
                                            MadridRepository.self)
        DependencyContainer.shared.register(GetDogsInformationRepositoryContract.self,
                                            MadridRepository.self)
        DependencyContainer.shared.register(GetMarketsInformationRepositoryContract.self,
                                            MadridRepository.self)
    }
}
