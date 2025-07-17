//
//  DomainModule.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

final class DomainModule: ModuleContract {
    static func inject() {
        DependencyContainer.shared.register(GetEventsCalendarUseCaseContract.self,
                                            GetEventsCalendarUseCase.self)
        DependencyContainer.shared.register(GetDogsInformationUseCaseContract.self,
                                            GetDogsInformationUseCase.self)
        DependencyContainer.shared.register(GetUserDistritUseCaseContract.self,
                                            GetUserDistritUseCase.self)
        DependencyContainer.shared.register(UserLocationManagerContract.self,
                                            UserLocationManager.self)
    }
}
