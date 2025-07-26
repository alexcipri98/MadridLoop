//
//  LandingDogSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingDogSectionMapperContract: SectionMapperContract {}

open class LandingDogSectionMapper: LandingDogSectionMapperContract {
    public typealias RenderModel = LandingDogSectionRenderModel
    
    public typealias ViewModel = LandingDogSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher

        return Publishers.CombineLatest(loadingPublisher,
                                        errorPublisher).map { loading, error in
            return (loading || error)
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: Bool) -> LandingDogSectionRenderModel {
        let renderData = RenderModel.LandingDogSectionData(title: "Amigo Canino",
                                                           description: "Encuentra bolsas, fuentes y parques cercanos para tu perro.",
                                                           icon: "pawprint.fill")
        return model ? LandingDogSectionRenderModel.hidden : .show(renderData)
    }
    
}
