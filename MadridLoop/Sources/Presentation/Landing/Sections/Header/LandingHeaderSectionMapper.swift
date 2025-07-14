//
//  LandingHeaderSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingHeaderSectionMapperContract: SectionMapperContract {}

open class LandingHeaderSectionMapper: LandingHeaderSectionMapperContract {
    public typealias RenderModel = LandingHeaderSectionRenderModel
    
    public typealias ViewModel = LandingHeaderSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> LandingHeaderSectionRenderModel {
        model ? LandingHeaderSectionRenderModel.hidden : .show(title: "Eventos Madrid")
    }
    
}
