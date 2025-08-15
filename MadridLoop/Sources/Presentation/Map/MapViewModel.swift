//
//  MapViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine

open class MapViewModelDependencies {
    public let navigationModel: MapScreenNavigationModel
    
    public init(navigationModel: MapScreenNavigationModel) {
        self.navigationModel = navigationModel
    }
}

public protocol MapViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: MapViewModelDependencies)
    func notifyAppearance()
}

open class MapViewModel: MapHeaderSectionViewModelContract,
                         MapContentSectionViewModelContract,
                         MapViewModelContract,
                         MapFiltersSectionViewModelContract {
    public let navigationBuilder: MapNavigationBuilderContract
    public let locationManager: UserLocationManagerContract
    
    public required init(){
        @Injected var locationManager: UserLocationManagerContract
        @Injected var navigationBuilder: MapNavigationBuilderContract
        self.navigationBuilder = navigationBuilder
        self.locationManager = locationManager
    }
    
    //init() {}
    
    @Published public var loadingPublished: Bool = true
    @Published public var errorPublished: Bool = false
    @Published public var locationPublished: LocationPresentationModel?
    @Published public var filtersIsSelectedPublished: [AvailableFilters: Bool] = AvailableFilters.getEmptyFilters()
    @Published public var dateFilter: Date? = nil

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }
    
    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }
    
    public var locationPublisher: AnyPublisher<LocationPresentationModel?, Never> {
        $locationPublished.eraseToAnyPublisher()
    }
    
    public var filtersIsSelectedPublisher: AnyPublisher<[AvailableFilters: Bool], Never> {
        $filtersIsSelectedPublished.eraseToAnyPublisher()
    }

    public var dateFilterPublisher: AnyPublisher<Date?, Never> {
        $dateFilter.eraseToAnyPublisher()
    }

    @Dependency public var navigationModel: MapScreenNavigationModel
    
    open func setupDependencies(_ dependencies: MapViewModelDependencies) {
        self.navigationModel = dependencies.navigationModel
    }
    private var cancellables = Set<AnyCancellable>()
    
    open func notifyAppearance() {
        locationManager.locationPublisher
            .compactMap { $0 }
            .first()
            .sink { [weak self] location in
                guard let self = self else { return }
                self.locationPublished = LocationPresentationModel(
                    userLocation: location,
                    identifier: self.navigationModel.identifier,
                    places: self.navigationModel.places,
                    action: self.navigationModel.action
                )
                self.loadingPublished = false
            }
            .store(in: &cancellables)
    }
    
    open func goBack() {
        navigationBuilder.goBack()
    }
    
    open func openSettings() {
        navigationBuilder.goToSettings()
    }

    open func didSelectDate(date: Date) {
        dateFilter = date
    }

    open func didToggleFilter(filter: AvailableFilters) {
        filtersIsSelectedPublished[filter]?.toggle()
    }
}
