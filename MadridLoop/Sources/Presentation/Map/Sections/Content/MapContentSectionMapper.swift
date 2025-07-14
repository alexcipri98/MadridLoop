//
//  MapHeaderSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol MapHeaderSectionMapperContract: SectionMapperContract {}

open class MapHeaderSectionMapper: MapHeaderSectionMapperContract {
    public typealias RenderModel = MapHeaderSectionRenderModel
    
    public typealias ViewModel = MapHeaderSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> MapHeaderSectionRenderModel {
        model ? MapHeaderSectionRenderModel.hidden : .show(title: "Mapa de Madrid")
    }
    
}
