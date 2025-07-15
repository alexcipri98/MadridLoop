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
                         MapViewModelContract {

    public let navigationBuilder: MapNavigationBuilderContract
    public let locationManager: UserLocationManagerContract

    public required init(){
        @Injected var locationManager: UserLocationManagerContract
        @Injected var navigationBuilder: MapNavigationBuilderContract
        self.navigationBuilder = navigationBuilder
        self.locationManager = locationManager
    }

    //init() {}

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var locationPublished: MapPresentationModel?

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }

    public var locationPublisher: AnyPublisher<MapPresentationModel?, Never> {
        $locationPublished.eraseToAnyPublisher()
    }

    @Dependency public var navigationModel: MapScreenNavigationModel

    open func setupDependencies(_ dependencies: MapViewModelDependencies) {
        self.navigationModel = dependencies.navigationModel
    }
    private var cancellables = Set<AnyCancellable>()

    open func notifyAppearance() {
        locationManager.locationPublisher
                .compactMap { $0 } // omite nils
                .first() // solo la primera ubicación válida
                .sink { [weak self] location in
                    guard let self = self else { return }
                    self.locationPublished = MapPresentationModel(
                        userLocation: location,
                        identifier: self.navigationModel.identifier,
                        places: self.navigationModel.places,
                        iconName: self.navigationModel.iconName,
                        action: self.navigationModel.action
                    )
                }
                .store(in: &cancellables)
    }

    open func goBack() {
        navigationBuilder.goBack()
    }

    open func openSettings() {
        navigationBuilder.goToSettings()
    }
}
