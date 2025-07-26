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
    open func getLoaderOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    open func getTopView() -> some View {
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
    open func getContentView() -> some View {
        getErrorView()

        @Injected var mapperDog: any LandingDogSectionMapperContract
        if let mapperInstance = mapperDog as? LandingDogSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LandingDogSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingDogSectionView(publisher: renderPublisher,
                                      viewModel: viewModel as! LandingDogSectionViewModelContract)
            .padding(.vertical)
        } else {
            EmptyView()
        }

        @Injected var mapper: any LandingEventSectionMapperContract
        if let mapperInstance = mapper as? LandingEventSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LandingEventSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingEventSectionView(publisher: renderPublisher,
                                      viewModel: viewModel as! LandingEventSectionViewModelContract)
            .padding(.vertical)
        } else {
            EmptyView()
        }

        @Injected var mapperMarkets: any LandingMarketsSectionMapperContract
        if let mapperMarketsInstance = mapperMarkets as? LandingMarketsSectionMapper {
            let publisher = mapperMarketsInstance.getObservedPublisher(viewModel as! LandingMarketsSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperMarketsInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingMarketsSectionView(publisher: renderPublisher,
                                      viewModel: viewModel as! LandingMarketsSectionViewModelContract)
            .padding(.vertical)
        } else {
            EmptyView()
        }

    }

    @ViewBuilder
    open func getBottomView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    open func getErrorView() -> some View {
        @Injected var mapperDog: any LandingGenericErrorSectionMapperContract
        if let mapperInstance = mapperDog as? LandingGenericErrorSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LandingGenericErrorSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LandingGenericErrorSectionView(publisher: renderPublisher,
                                           viewModel: viewModel as! LandingGenericErrorSectionViewModelContract)
            .padding(.vertical)
        } else {
            EmptyView()
        }
    }
}

