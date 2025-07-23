//
//  MapFiltersSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol MapFiltersSectionMapperContract: SectionMapperContract {}

open class MapFiltersSectionMapper: MapFiltersSectionMapperContract {
    public typealias RenderModel = MapFiltersSectionRenderModel
    
    public typealias ViewModel = MapFiltersSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show(MapPresentationModel, [AvailableFilters: Bool])
        case error
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ViewState, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.locationPublisher
        let filterIsSelectedPublisher = viewModel.filtersIsSelectedPublisher

        return Publishers.CombineLatest4(loadingPublisher, errorPublisher, dataPublisher, filterIsSelectedPublisher).map { loader, error, data, isfilterSelected in
            if loader {
                return .hidden
            } else if error {
                return .error
            } else {
                if let data = data {
                    return .show(data, isfilterSelected)
                } else {
                    return .hidden
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ViewState) -> MapFiltersSectionRenderModel {
        switch model {
        case .show(let entries, let isFilterSelected):
            let renderData = RenderModel.MapFiltersSectionRenderModelData(filters: ["HOY"], isFilterSelected: isFilterSelected)
            
            return .show(renderData: renderData)
        case .error:
            return .error
        case .hidden:
            return .hidden
        }
    }
    
}
