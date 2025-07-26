//
//  ListEventsHeaderSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListEventsHeaderSectionMapperContract: SectionMapperContract {}

open class ListEventsHeaderSectionMapper: ListEventsHeaderSectionMapperContract {
    public typealias RenderModel = ListEventsHeaderSectionRenderModel
    
    public typealias ViewModel = ListEventsHeaderSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> ListEventsHeaderSectionRenderModel {
        model ? ListEventsHeaderSectionRenderModel.hidden : .show(title: "Lista de eventos")
    }
    
}
