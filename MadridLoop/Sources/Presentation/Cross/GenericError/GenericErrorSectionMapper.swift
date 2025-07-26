//
//  GenericErrorSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol GenericErrorSectionMapperContract: SectionMapperContract {}

open class GenericErrorSectionMapper: GenericErrorSectionMapperContract {
    public typealias RenderModel = GenericErrorSectionRenderModel
    
    public typealias ViewModel = GenericErrorSectionViewModelContract
    
    public typealias ObservedModel = Bool

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<Bool, Never> {
        viewModel.errorPublisher.eraseToAnyPublisher()
    }

    public func map(_ model: Bool) -> GenericErrorSectionRenderModel {
        let renderData = RenderModel.GenericErrorSectionData(title: "Ha ocurrido un error",
                                                             description: "Es posible que nuestros servidores estén en mantenimiento. Inténtelo más tarde. \n Algunas funcionalidades requieren que usted esté fisicamente en Madrid.",
                                                             icon: "exclamationmark.triangle.fill",
                                                             buttonText: "Inténtalo de nuevo")
        return model ? .show(renderData) : GenericErrorSectionRenderModel.hidden
    }
    
}
