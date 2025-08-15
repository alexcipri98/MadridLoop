//
//  VersionUpdateContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol VersionUpdateContentSectionMapperContract: SectionMapperContract {}

open class VersionUpdateContentSectionMapper: VersionUpdateContentSectionMapperContract {
    public typealias RenderModel = VersionUpdateContentSectionRenderModel
    
    public typealias ViewModel = VersionUpdateContentSectionViewModelContract
    
    public typealias ObservedModel = VersionModel?
    
    @Dependency public var viewModel: any ViewModel
    
    public required init() {}
    
    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        return viewModel.versionUpdatePublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> RenderModel {
        return RenderModel(iconName: "arrow.triangle.2.circlepath.circle",
                           text: "¡Nueva versión disponible! Actualiza ahora para disfrutar de mejoras y nuevas funciones.",
                           url: URL(string: model?.url ?? ""))
    }
}
