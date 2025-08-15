//
//  ListEventsViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine
import MapKit

open class ListEventsViewModelDependencies {
    public init(identifier: String) {}
}

public protocol ListEventsViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: ListEventsViewModelDependencies)
    func notifyAppearance()
}

open class ListEventsViewModel: ListEventsHeaderSectionViewModelContract,
                                ListEventsFiltersSectionViewModelContract,
                                ListEventsContentSectionViewModelContract,
                                ListEventsViewModelContract {

    public let getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
    public let getDogsInformationUseCase: GetDogsInformationUseCaseContract
    public let navigationBuilder: ListEventsNavigationBuilderContract
    public let getUserDistritCodeUseCase: GetUserDistritUseCaseContract
    public let getMarketsUseCase: GetMarketsUseCaseContract

    public required init(){
        @Injected var getEventsCalendarUseCase: GetEventsCalendarUseCaseContract
        @Injected var getDogsInformationUseCase: GetDogsInformationUseCaseContract
        @Injected var navigationBuilder: ListEventsNavigationBuilderContract
        @Injected var getUserDistritUseCase: GetUserDistritUseCaseContract
        @Injected var getMarketsUseCase: GetMarketsUseCaseContract
        self.getUserDistritCodeUseCase = getUserDistritUseCase
        self.navigationBuilder = navigationBuilder
        self.getEventsCalendarUseCase = getEventsCalendarUseCase
        self.getDogsInformationUseCase = getDogsInformationUseCase
        self.getMarketsUseCase = getMarketsUseCase
    }

    //init() {}

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var filteredEntriesPublished: [EventEntryModel] = []
    public var allEntries: [EventEntryModel] = []

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }

    public var filteredEntriesPublisher: AnyPublisher<[EventEntryModel], Never> {
        $filteredEntriesPublished.eraseToAnyPublisher()
    }

    @Dependency public var identifier: String

    open func setupDependencies(_ dependencies: ListEventsViewModelDependencies) {}

    open func notifyAppearance() {
        loadInitialData()
    }

    open func getEventForEvents() {}

    open func entryTapped(at index: Int) {}

    open func goBack() {
        navigationBuilder.goBack()
    }

    open func howToGoTapped(lat: Double, lon: Double) {
        let destination = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let placemark = MKPlacemark(coordinate: destination)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destino"
        mapItem.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
        ])
    }

    open func didSelectDate(date: Date) {
        let calendar = Calendar.current
        self.filteredEntriesPublished = allEntries.filter { entry in
            guard let startTime = entry.dtStart.parseStringToDate() else { return true }
            if let endTime = entry.dtEnd?.parseStringToDate() {
                return startTime <= date && date <= endTime
            } else {
                return calendar.isDate(startTime, equalTo: date, toGranularity: .day)
            }
        }
    }
}

private extension ListEventsViewModel {
    func loadInitialData() {
        loadingPublished = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                self.loadingPublished = true
                async let events: [EventEntryModel] = getEventsCalendarUseCase.run(GetEventsCalendarUseCaseParameters())
                self.allEntries = try await events
                self.filteredEntriesPublished = self.allEntries
            } catch {
                self.errorPublished = true
            }
        }
    }
}
