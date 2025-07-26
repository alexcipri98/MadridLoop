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
        case show(LocationPresentationModel, [AvailableFilters: Bool])
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
            let iconNames = entries.places.map(\.iconName)
            let hasStartTime = entries.places.contains { $0.startTime != nil }

            let iconToFilterMap: [(String, RenderModel.Filters)] = [
                (IconsNames.trash.rawValue, .trash),
                (IconsNames.normalFont.rawValue, .font),
                (IconsNames.dogFont.rawValue, .dogFont),
                (IconsNames.park.rawValue, .park)
            ]

            var filters: [RenderModel.Filters] = iconToFilterMap.compactMap { icon, filter in
                iconNames.contains(icon) ? filter : nil
            }

            if hasStartTime {
                filters.insert(.date, at: 0)
            }

            let renderData = RenderModel.MapFiltersSectionRenderModelData(filters: filters, isFilterSelected: isFilterSelected)
            
            return .show(renderData: renderData)
        case .error:
            return .error
        case .hidden:
            return .hidden
        }
    }
    
}
