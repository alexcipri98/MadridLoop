//
//  LocationPermissionContentSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LocationPermissionContentSectionMapperContract: SectionMapperContract {}

open class LocationPermissionContentSectionMapper: LocationPermissionContentSectionMapperContract {
    public typealias RenderModel = LocationPermissionContentSectionRenderModel
    
    public typealias ViewModel = LocationPermissionContentSectionViewModelContract
    
    public typealias ObservedModel = VersionModel?
    
    @Dependency public var viewModel: any ViewModel
    
    public required init() {}
    
    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        return viewModel.LocationPermissionPublisher.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> RenderModel {
        return RenderModel(iconName: "arrow.triangle.2.circlepath.circle",
                           text: "Necesitamos el permiso de ubicación para poder ofrecerte todos nuestros servicios.")
    }
}
