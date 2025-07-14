//
//  DataModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class DataModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(MadridAPIContract.self,
                                            MadridAPI.self)
        DependencyContainer.shared.register(GetEventsCalendarRemoteDataSourceContract.self,
                                            MadridRemoteDataSource.self)
        DependencyContainer.shared.register(LandingEntriesEntityMapperContract.self,
                                            LandingEntriesEntityMapper.self)
        DependencyContainer.shared.register(GetEventsCalendarRepositoryContract.self,
                                            MadridRepository.self)
    }
}
