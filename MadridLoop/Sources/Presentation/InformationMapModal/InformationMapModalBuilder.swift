//
//  InformationMapModalBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class InformationMapModalBuilder {
    public var viewModel: InformationMapModalViewModelContract
    
    @Dependency public var navigationModel: InformationMapModalNavigationModel
    
    public required init() {
        @Injected var viewModel: InformationMapModalViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: InformationMapModalViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        viewModel.setupDependencies(InformationMapModalViewModelDependencies(navigationModel: navigationModel))
        return InformationMapModalScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getLoaderOverlayView)
    }

    open func setNavigationModel(_ navigationModel: InformationMapModalNavigationModel) -> InformationMapModalBuilder {
        self.navigationModel = navigationModel
        return self
    }

    @ViewBuilder
    public func getLoaderOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getTopView() -> some View {
        @Injected var informationHeaderSectionMapper: any InformationMapModalHeaderSectionMapperContract
        if let informationHeaderSectionMapperInstance = informationHeaderSectionMapper as? InformationMapModalHeaderSectionMapper {
            let publisher = informationHeaderSectionMapperInstance.getObservedPublisher(viewModel as! InformationMapModalHeaderSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                informationHeaderSectionMapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            InformationMapModalHeaderSectionView(publisher: renderPublisher, viewModel: viewModel as! InformationMapModalHeaderSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var informationContentSectionMapper: any InformationMapModalContentSectionMapperContract
        if let informationContentSectionMapperInstance = informationContentSectionMapper as? InformationMapModalContentSectionMapper {
            let publisher = informationContentSectionMapperInstance.getObservedPublisher(viewModel as! InformationMapModalContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                informationContentSectionMapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            InformationMapModalContentSectionView(publisher: renderPublisher, viewModel: viewModel as! InformationMapModalContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}
