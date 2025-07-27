//
//  ListMerchantsBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class ListMerchantsBuilder {
    public var viewModel: ListMerchantsViewModelContract
    
    @Dependency public var identifier: String
    
    public required init() {
        @Injected var viewModel: ListMerchantsViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: ListMerchantsViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        return ListMerchantsScreen(viewModel: viewModel,
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
        @Injected var mapper: any ListMerchantsHeaderSectionMapperContract
        if let mapperInstance = mapper as? ListMerchantsHeaderSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! ListMerchantsHeaderSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            ListMerchantsHeaderSectionView(publisher: renderPublisher, viewModel: viewModel as! ListMerchantsHeaderSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var mapper: any ListMerchantsContentSectionMapperContract
        if let mapperInstance = mapper as? ListMerchantsContentSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! ListMerchantsContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            ListMerchantsContentSectionView(publisher: renderPublisher, viewModel: viewModel as! ListMerchantsContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}

