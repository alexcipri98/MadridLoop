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

    public let getUserLocationUseCase: GetUserLocationUseCaseContract
    public let navigationBuilder: MapNavigationBuilderContract

    public required init(){
        @Injected var getUserLocationUseCase: GetUserLocationUseCaseContract
        @Injected var navigationBuilder: MapNavigationBuilderContract
        self.navigationBuilder = navigationBuilder
        self.getUserLocationUseCase = getUserLocationUseCase
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
    
    open func notifyAppearance() {
        refreshUserLocation()
    }

    open func goBack() {
        navigationBuilder.goBack()
    }
    
    open func refreshUserLocation() {
        let params = GetUserLocationUseCaseParameters()
        let userLocation = getUserLocationUseCase.run(params)
        locationPublished = MapPresentationModel(userLocation: userLocation,
                                                 identifier: navigationModel.identifier,
                                                 places: navigationModel.places,
                                                 iconName: navigationModel.iconName,
                                                 action: navigationModel.action)
    }
}
