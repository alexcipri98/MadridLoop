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
                             LandingMarketsSectionViewModelContract,
                             LandingGenericErrorSectionViewModelContract,
                             LandingViewModelContract {

    public let getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
    public let getDogsInformationUseCase: GetDogsInformationUseCaseContract
    public let navigationBuilder: LandingNavigationBuilderContract
    public let getUserDistritCodeUseCase: GetUserDistritUseCaseContract
    public let getMarketsUseCase: GetMarketsUseCaseContract

    public required init(){
        @Injected var getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
        @Injected var getDogsInformationUseCase: GetDogsInformationUseCaseContract
        @Injected var navigationBuilder: LandingNavigationBuilderContract
        @Injected var getUserDistritUseCase: GetUserDistritUseCaseContract
        @Injected var getMarketsUseCase: GetMarketsUseCaseContract
        self.getUserDistritCodeUseCase = getUserDistritUseCase
        self.navigationBuilder = navigationBuilder
        self.getEventsCalendarUseCase = getEventsCalendarUseCase
        self.getDogsInformationUseCase = getDogsInformationUseCase
        self.getMarketsUseCase = getMarketsUseCase
    }

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var entriesPublished: [EventEntryModel] = []
    @Published public var marketsPublished: [MarketInformationModel] = []

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }

    public var entriesPublisher: AnyPublisher<[EventEntryModel], Never> {
        $entriesPublished.eraseToAnyPublisher()
    }

    public var marketsPublisher: AnyPublisher<[MarketInformationModel], Never> {
        $marketsPublished.eraseToAnyPublisher()
    }

    @Dependency public var identifier: String

    open func setupDependencies(_ dependencies: LandingViewModelDependencies) {
        self.identifier = dependencies.identifier
    }

    open func notifyAppearance() {
        loadInitialData()
    }

    open func getEventForEntries() {}

    open func entryTapped(at index: Int) {
        guard entriesPublished.indices.contains(index) else { return }
        let event = entriesPublished[index]
    }

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
                let dogsInformation = try await getDogsInformationUseCase.run(params)
                var places = [Location]()
                for entry in dogsInformation {
                    if let location = Location.fromDogToLocation(entry) {
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
            } catch {
                self.errorPublished = true
            }
        }
    }

    open func lookInMapMarketsTapped() {
        var places = [Location]()
        for entry in marketsPublished {
            if let location = Location.fromMarketsToLocation(entry) {
                places.append(location)
            }
        }
        let navigationModel = MapScreenNavigationModel(identifier: identifier,
                                                       places: places,
                                                       action: { [weak self] identifier in
            guard let self = self else { return }
            if let market = marketsPublished.first(where: {$0.id == identifier}) {
                self.marketTappedOnMap(market)
            } else {
                self.errorPublished = true
            }
        })
        navigationBuilder.navigateToMapScreen(mapScreenNavigationModel: navigationModel)
    }

    open func lookInListEventsTapped() {
        navigationBuilder.navigateToListEvents()
    }

    open func lookInListMerchantsTapped() {
        navigationBuilder.navigateToListMerchants()
    }

    open func tryAgain() {
        notifyAppearance()
    }
}

private extension LandingViewModel {
    func loadInitialData() {
        self.loadingPublished = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                self.errorPublished = false
                self.loadingPublished = true
                async let events: [EventEntryModel] = getEventsCalendarUseCase.run(GetEventsCalendarUseCaseParameters())
                async let markets: [MarketInformationModel] = getMarketsUseCase.run(GetMarketsUseCaseParameters())
                (self.entriesPublished, self.marketsPublished) = try await (events, markets)
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

    func marketTappedOnMap(_ market: MarketInformationModel) {
        var description = ""
        if let index = market.services?.firstIndex(of: ".") {
            description = String(market.services?[..<index] ?? "")
        }
        let location = Location.fromMarketsToLocation(market)
        let informationMapModalNavigationModel = InformationMapModalNavigationModel(title: market.title ?? "Sin título",
                                                                                    description: description,
                                                                                    location: location,
                                                                                    link: market.relation,
                                                                                    schedule: market.schedule)
        navigationBuilder.navigateToModal(informationMapModalNavigationModel)
    }
}
