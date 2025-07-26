//
//  ListEventsBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class ListEventsBuilder {
    public var viewModel: ListEventsViewModelContract
    
    @Dependency public var identifier: String
    
    public required init() {
        @Injected var viewModel: ListEventsViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: ListEventsViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        return ListEventsScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getLoaderOverlayView)
    }

    @ViewBuilder
    public func getLoaderOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getTopView() -> some View {
        @Injected var mapper: any ListEventsHeaderSectionMapperContract
        if let mapperInstance = mapper as? ListEventsHeaderSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! ListEventsHeaderSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            ListEventsHeaderSectionView(publisher: renderPublisher, viewModel: viewModel as! ListEventsHeaderSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var mapperList: any ListEventsFiltersSectionMapperContract
        if let mapperInstance = mapperList as? ListEventsFiltersSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! ListEventsFiltersSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            ListEventsFiltersSectionView(publisher: renderPublisher, viewModel: viewModel as! ListEventsFiltersSectionViewModelContract)
        } else {
            EmptyView()
        }

        @Injected var mapper: any ListEventsContentSectionMapperContract
        if let mapperInstance = mapper as? ListEventsContentSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! ListEventsContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            ListEventsContentSectionView(publisher: renderPublisher, viewModel: viewModel as! ListEventsContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}

