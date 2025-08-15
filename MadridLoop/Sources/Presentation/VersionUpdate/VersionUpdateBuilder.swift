//
//  VersionUpdateBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class VersionUpdateBuilder {
    public var viewModel: VersionUpdateViewModelContract
    
    @Dependency public var navigationModel: VersionModel
    
    public required init() {
        @Injected var viewModel: VersionUpdateViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: VersionUpdateViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        viewModel.setupDependencies(VersionUpdateViewModelDependencies(navigationModel: navigationModel))
        return VersionUpdateScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getOverlayView)
    }

    open func setNavigationModel(_ navigationModel: VersionModel) -> VersionUpdateBuilder {
        self.navigationModel = navigationModel
        return self
    }

    @ViewBuilder
    public func getOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getTopView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var mapper: any VersionUpdateContentSectionMapperContract
        if let mapperInstance = mapper as? VersionUpdateContentSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! VersionUpdateContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            VersionUpdateContentSectionView(publisher: renderPublisher, viewModel: viewModel as! VersionUpdateContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}
