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
        case show(MapPresentationModel)
        case error
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ViewState, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.locationPublisher

        return Publishers.CombineLatest3(loadingPublisher, errorPublisher, dataPublisher).map { loader, error, data in
            if loader {
                return .hidden
            } else if error {
                return .error
            } else {
                if let data = data {
                    return .show(data)
                } else {
                    return .hidden
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ViewState) -> MapContentSectionRenderModel {
        switch model {
        case .show(let entries):
            let renderData = RenderModel.MapContentSectionRenderModelData(userLocation: entries.userLocation,
                                                                          identifier: entries.identifier,
                                                                          places: entries.places,
                                                                          iconName: entries.iconName,
                                                                          action: entries.action)
            
            return .show(renderData: renderData)
        case .error:
            return .error
        case .hidden:
            return .hidden
        }
    }
    
}
