//
//  LocationPermissionBuilder.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 14/7/25.
//

import DependencyInjector
import PresentationLayer
import SwiftUI

open class LocationPermissionBuilder {
    public var viewModel: LocationPermissionViewModelContract

    public required init() {
        @Injected var viewModel: LocationPermissionViewModelContract
        self.viewModel = viewModel
    }
    
    init(viewModel: LocationPermissionViewModelContract) {
        self.viewModel = viewModel
    }
    
    open func build() -> any View {
        return LocationPermissionScreen(viewModel: viewModel,
                             top: getTopView,
                             content: getContentView,
                             bottom: getBottomView,
                             overlay: getOverlayView)
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
        @Injected var mapper: any LocationPermissionContentSectionMapperContract
        if let mapperInstance = mapper as? LocationPermissionContentSectionMapper {
            let publisher = mapperInstance.getObservedPublisher(viewModel as! LocationPermissionContentSectionViewModelContract)
            let renderPublisher = publisher.map { domainModel in
                mapperInstance.map(domainModel)
            }.eraseToAnyPublisher()
            LocationPermissionContentSectionView(publisher: renderPublisher, viewModel: viewModel as! LocationPermissionContentSectionViewModelContract)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    public func getBottomView() -> some View {
        EmptyView()
    }
}
