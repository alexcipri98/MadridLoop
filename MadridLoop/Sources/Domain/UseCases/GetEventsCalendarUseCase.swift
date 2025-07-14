//
//  GetEventsCalendarUseCase.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector

open class GetEventsCalendarUseCaseParameters {
    public init() {}
}

public protocol GetEventsCalendarUseCaseContract: Instanciable {
    func run(_ parameters: GetEventsCalendarUseCaseParameters) async throws -> [LandingEntryModel]
}

open class GetEventsCalendarUseCase: GetEventsCalendarUseCaseContract {
    public let repository: GetEventsCalendarRepositoryContract

    required public init() {
        @Injected var repository: GetEventsCalendarRepositoryContract
        self.repository = repository
    }
    
    public func run(_ parameters: GetEventsCalendarUseCaseParameters) async throws -> [LandingEntryModel] {
        return try await repository.getEventsCalendar()
    }
}
