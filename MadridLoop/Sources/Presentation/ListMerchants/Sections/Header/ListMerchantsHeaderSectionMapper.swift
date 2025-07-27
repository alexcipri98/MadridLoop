//
//  ListMerchantsHeaderSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol ListMerchantsHeaderSectionMapperContract: SectionMapperContract {}

open class ListMerchantsHeaderSectionMapper: ListMerchantsHeaderSectionMapperContract {
    public typealias RenderModel = ListMerchantsHeaderSectionRenderModel
    
    public typealias ViewModel = ListMerchantsHeaderSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> ListMerchantsHeaderSectionRenderModel {
        model ? ListMerchantsHeaderSectionRenderModel.hidden : .show(title: "Lista de eventos")
    }
    
}
