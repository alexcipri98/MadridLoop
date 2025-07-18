//
//  LandingMarketsSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingMarketsSectionMapperContract: SectionMapperContract {}

open class LandingMarketsSectionMapper: LandingMarketsSectionMapperContract {
    public typealias RenderModel = LandingMarketsSectionRenderModel
    
    public typealias ViewModel = LandingMarketsSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.loadingPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> LandingMarketsSectionRenderModel {
        let renderData = RenderModel.LandingMarketsSectionData(title: "Amigo Canino",
                                                           description: "Encuentra bolsas, fuentes y parques cercanos para tu perro.",
                                                           icon: "pawprint.fill")
        return model ? LandingMarketsSectionRenderModel.hidden : .show(renderData)
    }
    
}
