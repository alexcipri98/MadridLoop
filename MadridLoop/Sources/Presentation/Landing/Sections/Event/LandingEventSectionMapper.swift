//
//  LandingEventSectionMapper.swift
//  MadridLoop
//
//  Created by Alex Ciprian lopez on 13/7/25.
//

import Combine
import PresentationLayer

public protocol LandingEventSectionMapperContract: SectionMapperContract {}

open class LandingEventSectionMapper: LandingEventSectionMapperContract {
    public typealias RenderModel = LandingEventSectionRenderModel
    
    public typealias ViewModel = LandingEventSectionViewModelContract
    
    public typealias ObservedModel = ViewState

    @Dependency public var viewModel: any ViewModel

    public required init() {}

    public enum ViewState {
        case show([EventEntryModel])
        case hidden
    }

    public func getObservedPublisher(_ viewModel: any ViewModel) -> AnyPublisher<ObservedModel, Never> {
        let loadingPublisher = viewModel.loadingPublisher
        let errorPublisher = viewModel.errorPublisher
        let dataPublisher = viewModel.entriesPublisher

        return Publishers.CombineLatest3(loadingPublisher, errorPublisher, dataPublisher).map { loader, error, data in
            if loader || error {
                return .hidden
            } else {
                return .show(data)
            }
        }.eraseToAnyPublisher()
    }
    
    public func map(_ model: ObservedModel) -> LandingEventSectionRenderModel {
        switch model {
        case .show(let entries):
            var result: [RenderModel.LandingEventDataRenderModel] = []
            for entry in entries {
                result.append(RenderModel.LandingEventDataRenderModel(id: entry.id,
                                                                        title: entry.title,
                                                                        description: entry.description,
                                                                        dateStart: entry.dtStart,
                                                                        isItFree: entry.price == "Entrada gratuita",
                                                                        location: entry.address?.locality,
                                                                        link: entry.link,
                                                                        latitude: entry.location?.latitude,
                                                                        longitude: entry.location?.longitude))
            }
            return .show(result)
        case .hidden:
            return .hidden
        }
    }
    
}

