//
//  ListMerchantsViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine
import MapKit
import FirebaseAnalytics

open class ListMerchantsViewModelDependencies {
    public init(identifier: String) {}
}

public protocol ListMerchantsViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: ListMerchantsViewModelDependencies)
    func notifyAppearance()
}

open class ListMerchantsViewModel: ListMerchantsHeaderSectionViewModelContract,
                                   ListMerchantsContentSectionViewModelContract,
                                   ListMerchantsViewModelContract {

    public let getMarketsCalendarUseCase: GetMarketsUseCaseContract
    public let getDogsInformationUseCase: GetDogsInformationUseCaseContract
    public let navigationBuilder: ListMerchantsNavigationBuilderContract
    public let getUserDistritCodeUseCase: GetUserDistritUseCaseContract
    public let getMarketsUseCase: GetMarketsUseCaseContract

    public required init(){
        @Injected var getMarketsCalendarUseCase: GetMarketsUseCaseContract
        @Injected var getDogsInformationUseCase: GetDogsInformationUseCaseContract
        @Injected var navigationBuilder: ListMerchantsNavigationBuilderContract
        @Injected var getUserDistritUseCase: GetUserDistritUseCaseContract
        @Injected var getMarketsUseCase: GetMarketsUseCaseContract
        self.getUserDistritCodeUseCase = getUserDistritUseCase
        self.navigationBuilder = navigationBuilder
        self.getMarketsCalendarUseCase = getMarketsCalendarUseCase
        self.getDogsInformationUseCase = getDogsInformationUseCase
        self.getMarketsUseCase = getMarketsUseCase
    }

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var entriesPublished: [MarketInformationModel] = []

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }

    public var entriesPublisher: AnyPublisher<[MarketInformationModel], Never> {
        $entriesPublished.eraseToAnyPublisher()
    }

    @Dependency public var identifier: String

    open func setupDependencies(_ dependencies: ListMerchantsViewModelDependencies) {}

    open func notifyAppearance() {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: "ListMerchants"
        ])
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
}

private extension ListMerchantsViewModel {
    func loadInitialData() {
        loadingPublished = true
        Task { @MainActor [weak self] in
            guard let self else { return }
            defer {
                self.loadingPublished = false
            }
            do {
                self.loadingPublished = true
                async let markets: [MarketInformationModel] = getMarketsCalendarUseCase.run(GetMarketsUseCaseParameters())
                self.entriesPublished = try await markets
            } catch {
                self.errorPublished = true
            }
        }
    }
}
