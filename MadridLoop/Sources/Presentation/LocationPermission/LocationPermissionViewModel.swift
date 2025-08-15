//
//  LocationPermissionViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine
import FirebaseAnalytics
import UIKit

open class LocationPermissionViewModelDependencies {

    public init() {}
}

public protocol LocationPermissionViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: LocationPermissionViewModelDependencies)
    func notifyAppearance()
}

open class LocationPermissionViewModel: LocationPermissionContentSectionViewModelContract,
                                   LocationPermissionViewModelContract {
    public let checkLocationPermissionUseCase: CheckLocationPermissionUseCaseContract
    public let navigationBuilder: LocationPermissionNavigationBuilderContract

    public required init(){
        @Injected var checkLocationPermissionUseCase: CheckLocationPermissionUseCaseContract
        @Injected var navigationBuilder: LocationPermissionNavigationBuilderContract
        self.navigationBuilder = navigationBuilder
        self.checkLocationPermissionUseCase = checkLocationPermissionUseCase
    }
    
    @Published public var versionModel: VersionModel?
    public var LocationPermissionPublisher: AnyPublisher<VersionModel?, Never> {
        $versionModel.eraseToAnyPublisher()
    }

    
    open func setupDependencies(_ dependencies: LocationPermissionViewModelDependencies) {}
    
    open func notifyAppearance() {
        checkLocationPermission()
    }

    open func goToSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

private extension LocationPermissionViewModel {
    func checkLocationPermission() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let params = CheckLocationPermissionUseCaseParameters()
            let result = await checkLocationPermissionUseCase.run(params)
            if result {
                navigationBuilder.goBack()
            }
        }
    }
}
