//
//  VersionUpdateViewModel.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import Combine
import FirebaseAnalytics

open class VersionUpdateViewModelDependencies {
    public let navigationModel: VersionModel
    
    public init(navigationModel: VersionModel) {
        self.navigationModel = navigationModel
    }
}

public protocol VersionUpdateViewModelContract: ViewModelContract {
    func setupDependencies(_ dependencies: VersionUpdateViewModelDependencies)
    func notifyAppearance()
}

open class VersionUpdateViewModel: VersionUpdateContentSectionViewModelContract,
                                   VersionUpdateViewModelContract {
        
    public required init(){}

    @Dependency public var navigationModel: VersionModel
    
    @Published public var versionModel: VersionModel?
    public var versionUpdatePublisher: AnyPublisher<VersionModel?, Never> {
        $versionModel.eraseToAnyPublisher()
    }

    
    open func setupDependencies(_ dependencies: VersionUpdateViewModelDependencies) {
        self.navigationModel = dependencies.navigationModel
    }
    
    open func notifyAppearance() {
        versionModel = navigationModel
    }

}
