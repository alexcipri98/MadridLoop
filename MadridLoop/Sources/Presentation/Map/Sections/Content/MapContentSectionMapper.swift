//
//  MapContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol MapContentSectionMapperContract: SectionMapperContract {}

open class MapContentSectionMapper: MapContentSectionMapperContract {
    public typealias RenderModel = MapContentSectionRenderModel
    
    public typealias ViewModel = MapContentSectionViewModelContract
    
    public typealias ObservedModel = ViewState
    
    @Dependency public var viewModel: any ViewModel
    
    public required init() {}
    
    public enum ViewState {
        case show(LocationPresentationModel, [AvailableFilters: Bool], Date?)
        case error
        case hidden
    }
    
    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ViewState, Never> {
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.locationPublisher
        let filterIsSelectedPublisher = viewModel.filtersIsSelectedPublisher
        let dateFilterPublisher = viewModel.dateFilterPublisher

        return Publishers.CombineLatest4(dateFilterPublisher,
                                         errorPublisher,
                                         dataPublisher,
                                         filterIsSelectedPublisher).map { date, error, data, isfilterSelected in
            if error {
                return .error
            } else {
                if let data = data {
                    return .show(data, isfilterSelected, date)
                } else {
                    return .hidden
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ViewState) -> MapContentSectionRenderModel {
        switch model {
        case .show(let entries, let isFilterSelected, let date):
            let places = entries.places.filter {
                if $0.iconName == IconsNames.trash.rawValue {
                    return isFilterSelected[.isTrashFilterSelected] ?? true
                } else if $0.iconName == IconsNames.normalFont.rawValue {
                    return isFilterSelected[.isNormalFontsFilterSelected] ?? true
                } else if $0.iconName == IconsNames.dogFont.rawValue {
                    return isFilterSelected[.isDogsZonesFilterSelected] ?? true
                }
                return true
            }
            if let date = date {
                let calendar = Calendar.current
                let filteredPlacesByDate = places.filter {
                    guard let startTime = $0.startTime else { return true }
                    if let endTime = $0.endTime {
                        return startTime <= date && date <= endTime
                    } else {
                        return calendar.isDate(startTime, equalTo: date, toGranularity: .day)
                    }
                }
                let renderData = RenderModel.MapContentSectionRenderModelData(userLocation: entries.userLocation,
                                                                              identifier: entries.identifier,
                                                                              places: filteredPlacesByDate,
                                                                              action: entries.action,
                                                                              isFilterSelected: isFilterSelected)
                
                return .show(renderData: renderData)
            }
            let renderData = RenderModel.MapContentSectionRenderModelData(userLocation: entries.userLocation,
                                                                          identifier: entries.identifier,
                                                                          places: places,
                                                                          action: entries.action,
                                                                          isFilterSelected: isFilterSelected)
            
            return .show(renderData: renderData)
        case .error:
            return .error
        case .hidden:
            return .hidden
        }
    }
}
