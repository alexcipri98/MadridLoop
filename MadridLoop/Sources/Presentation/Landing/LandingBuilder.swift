//
//  LandingBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class LandingBuilder {
    public var viewModel: LandingViewModelContract
    
    @Dependency public var identifier: String
    
    public required init() {
        @Injected var viewModel: LandingViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: LandingViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        viewModel.setupDependencies(LandingViewModelDependencies(identifier: identifier))
        return LandingScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getLoaderOverlayView)
    }

    open func setIdentifier(_ identifier: String) -> LandingBuilder {
        self.identifier = identifier
        return self
    }

    @ViewBuilder
    public func getLoaderOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getTopView() -> some View {
        @Injected var mapper: any LandingHeaderSectionMapperContract
        if let mapperInstance = mapper as? LandingHeaderSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LandingHeaderSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingHeaderSectionView(publisher: renderPublisher, viewModel: viewModel as! LandingHeaderSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var mapper: any LandingEventSectionMapperContract
        if let mapperInstance = mapper as? LandingEventSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LandingEventSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingEventSectionView(publisher: renderPublisher,
                                      viewModel: viewModel as! LandingEventSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}

