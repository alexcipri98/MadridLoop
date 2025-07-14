//
//  MapBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class MapBuilder {
    public var viewModel: MapViewModelContract
    
    @Dependency public var navigationModel: MapScreenNavigationModel
    
    public required init() {
        @Injected var viewModel: MapViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: MapViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        viewModel.setupDependencies(MapViewModelDependencies(navigationModel: navigationModel))
        return MapScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getLoaderOverlayView)
    }

    open func setNavigationModel(_ navigationModel: MapScreenNavigationModel) -> MapBuilder {
        self.navigationModel = navigationModel
        return self
    }

    @ViewBuilder
    public func getLoaderOverlayView() -> some View {
        EmptyView()
    }

    @ViewBuilder
    public func getTopView() -> some View {
        @Injected var mapper: any MapHeaderSectionMapperContract
        if let mapperInstance = mapper as? MapHeaderSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! MapHeaderSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            MapHeaderSectionView(publisher: renderPublisher, viewModel: viewModel as! MapHeaderSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getContentView() -> some View {
        @Injected var mapper: any MapContentSectionMapperContract
        if let mapperInstance = mapper as? MapContentSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! MapContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            MapContentSectionView(publisher: renderPublisher, viewModel: viewModel as! MapContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}
