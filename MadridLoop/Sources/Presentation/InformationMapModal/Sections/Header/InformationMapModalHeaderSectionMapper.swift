//
//  InformationMapModalHeaderSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol InformationMapModalHeaderSectionMapperContract: SectionMapperContract {}

open class InformationMapModalHeaderSectionMapper: InformationMapModalHeaderSectionMapperContract {
    public typealias RenderModel = InformationMapModalHeaderSectionRenderModel
    
    public typealias ViewModel = InformationMapModalHeaderSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> InformationMapModalHeaderSectionRenderModel {
        model ? InformationMapModalHeaderSectionRenderModel.hidden : .show(title: "Mapa de Madrid")
    }
    
}
