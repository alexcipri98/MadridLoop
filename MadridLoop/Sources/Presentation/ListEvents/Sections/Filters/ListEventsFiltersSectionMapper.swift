//
//  ListEventsFiltersSectionListEventsper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListEventsFiltersSectionMapperContract: SectionMapperContract {}

open class ListEventsFiltersSectionMapper: ListEventsFiltersSectionMapperContract {
    
    public typealias RenderModel = ListEventsFiltersSectionRenderModel
    
    public typealias ViewModel = ListEventsFiltersSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show
        case error
        case hidden
    }

    open func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ViewState, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher

        return Publishers.CombineLatest(loadingPublisher, errorPublisher).map { loader, error in
            if loader {
                return .hidden
            } else if error {
                return .error
            } else {
                return .show
            }
        }.eraseToAnyPublisher()
    }
    
    open func map(_ model: ViewState) -> ListEventsFiltersSectionRenderModel {
        switch model {
        case .show:
            return .show
        case .error:
            return .error
        case .hidden:
            return .hidden
        }
    }
    
}
