//
//  InformationMapModalViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine
import MapKit

open class InformationMapModalViewModelDependencies {
    public let navigationModel: InformationMapModalNavigationModel
    
    public init(navigationModel: InformationMapModalNavigationModel) {
        self.navigationModel = navigationModel
    }
}

public protocol InformationMapModalViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: InformationMapModalViewModelDependencies)
    func notifyAppearance()
}

open class InformationMapModalViewModel: InformationMapModalHeaderSectionViewModelContract,
                                         InformationMapModalContentSectionViewModelContract,
                                         InformationMapModalViewModelContract {

    public let navigationBuilder: InformationMapModalNavigationBuilderContract
    public let locationManager: UserLocationManagerContract

    public required init(){
        @Injected var locationManager: UserLocationManagerContract
        @Injected var navigationBuilder: InformationMapModalNavigationBuilderContract
        self.navigationBuilder = navigationBuilder
        self.locationManager = locationManager
    }

    //init() {}

    @Published public var loadingPublished: Bool = false
    @Published public var errorPublished: Bool = false
    @Published public var contentPublished: InformationMapModalPresentationModel?

    public var loadingPublisher: AnyPublisher<Bool, Never> {
        $loadingPublished.eraseToAnyPublisher()
    }

    public var errorPublisher: AnyPublisher<Bool, Never> {
        $errorPublished.eraseToAnyPublisher()
    }

    public var contentPublisher: AnyPublisher<InformationMapModalPresentationModel?, Never> {
        $contentPublished.eraseToAnyPublisher()
    }

    @Dependency public var navigationModel: InformationMapModalNavigationModel

    open func setupDependencies(_ dependencies: InformationMapModalViewModelDependencies) {
        self.navigationModel = dependencies.navigationModel
    }
    private var cancellables = Set<AnyCancellable>()

    open func notifyAppearance() {
        contentPublished = InformationMapModalPresentationModel(title: navigationModel.title,
                                                                description: navigationModel.description,
                                                                location: navigationModel.location,
                                                                link: navigationModel.link,
                                                                startTime: navigationModel.startTime,
                                                                schedule: navigationModel.schedule)
    }

    open func goBack() {
        navigationBuilder.goBack()
    }

    open func howToGoTapped() {
        if let destination = navigationModel.location?.coordinate {
            let placemark = MKPlacemark(coordinate: destination)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Destino"
            mapItem.openInMaps(launchOptions: [
                MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking
            ])
        } else {
            self.errorPublished = true
        }
    }
}
