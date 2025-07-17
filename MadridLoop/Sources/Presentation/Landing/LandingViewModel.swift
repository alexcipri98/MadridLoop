//
//  LandingViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine

open class LandingViewModelDependencies {
    public let identifier: String
    
    public init(identifier: String) {
        self.identifier = identifier
    }
}

public protocol LandingViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: LandingViewModelDependencies)
    func notifyAppearance()
}

open class LandingViewModel: LandingHeaderSectionViewModelContract,
                             LandingEventSectionViewModelContract,
                             LandingDogSectionViewModelContract,
                             LandingViewModelContract {

    public let getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
    public let getDogsInformationUseCase: GetDogsInformationUseCaseContract
    public let navigationBuilder: LandingNavigationBuilderContract
    public let getUserDistritCodeUseCase: GetUserDistritUseCaseContract

    public required init(){
        @Injected var getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
        @Injected var getDogsInformationUseCase: GetDogsInformationUseCaseContract
        @Injected var navigationBuilder: LandingNavigationBuilderContract
        @Injected var getUserDistritUseCase: GetUserDistritUseCaseContract
        self.getUserDistritCodeUseCase = getUserDistritUseCase
        self.navigationBuilder = navigationBuilder
        self.getEventsCalendarUseCase = getEventsCalendarUseCase
        self.getDogsInformationUseCase = getDogsInformationUseCase
    }

    //init() {}

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var entriesPublished: [EventEntryModel] = []

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }
    
    public var entriesPublisher: AnyPublisher<[EventEntryModel], Never> {
        $entriesPublished.eraseToAnyPublisher()
    }

    @Dependency public var identifier: String

    open func setupDependencies(_ dependencies: LandingViewModelDependencies) {
        self.identifier = dependencies.identifier
    }
    
    open func notifyAppearance() {
        loadInitialData()
    }

    open func getEventForEntries() {}
    
    open func entryTapped(at index: Int) {}

    open func lookInMapEventsTapped() {
        var places = [Location]()
        for entry in entriesPublished {
            if let location = Location.fromEventToLocation(entry) {
                places.append(location)
            }
        }
        let navigationModel = MapScreenNavigationModel(identifier: identifier,
                                                       places: places,
                                                       action: { [weak self] identifier in
            guard let self = self else { return }
            self.eventTappedOnMap(identifier)
        })
        navigationBuilder.navigateToMapScreen(mapScreenNavigationModel: navigationModel)
    }

    open func lookInMapDogsTapped() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                self.loadingPublished = true
                let distritParams = GetUserDistritUseCaseParameters()
                let distritCode = try await getUserDistritCodeUseCase.run(distritParams)
                let params = GetDogsInformationUseCaseParameters(userPostalCode: distritCode)
                let dogsTrashes = try await getDogsInformationUseCase.run(params)
                var places = [Location]()
                for entry in dogsTrashes {
                    if let location = Location.fromDogToLocation(entry) {
                        places.append(location)
                    }
                }
                let navigationModel = MapScreenNavigationModel(identifier: identifier,
                                                               places: places,
                                                               iconName: "pawprint.fill",
                                                               action: { [weak self] identifier in
                    guard let self = self else { return }
                    self.eventTappedOnMap(identifier)
                })
                navigationBuilder.navigateToMapScreen(mapScreenNavigationModel: navigationModel)
            } catch {
                self.errorPublished = true
            }
        }
    }
}

private extension LandingViewModel {
    func loadInitialData() {
        loadingPublished = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                self.loadingPublished = true
                let params = GetEventsCalendarUseCaseParameters()
                self.entriesPublished = try await getEventsCalendarUseCase.run(params)
            } catch {
                self.errorPublished = true
            }
        }
    }

    func eventTappedOnMap(_ identifier: String) {
        guard let event = entriesPublished.first(where: { $0.id == identifier }),
              let location = Location.fromEventToLocation(event) else {
            errorPublished = true
            return
        }
        let informationMapModalNavigationModel = InformationMapModalNavigationModel(title: event.title,
                                                                                    description: event.description,
                                                                                    location: location,
                                                                                    link: event.link,
                                                                                    startTime: event.dtStart)
            
        navigationBuilder.navigateToModal(informationMapModalNavigationModel)
    }
}
